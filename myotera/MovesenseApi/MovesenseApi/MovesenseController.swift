//
//  MovesenseController.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

protocol MovesenseControllerDelegate: class {

    func deviceDiscovered(_ device: MovesenseDeviceConcrete)

    func deviceConnecting(_ serialNumber: MovesenseSerialNumber)
    func deviceConnected(_ deviceInfo: MovesenseDeviceInfo,
                         _ connection: MovesenseConnection)
    func deviceDisconnected(_ serialNumber: MovesenseSerialNumber)

    func onControllerError(_ error: Error)
}

class MovesenseController: NSObject {

    weak var delegate: MovesenseControllerDelegate?

    private let jsonDecoder: JSONDecoder = JSONDecoder()
    private let bleController: MovesenseBleController
    private let mdsWrapper: MDSWrapper

    private weak var movesenseModel: MovesenseModel?

    init(model: MovesenseModel,
         bleController: MovesenseBleController) {

        self.movesenseModel = model
        self.bleController = bleController

        // Initialize MDSWrapper with a separate CBCentralManager created in BleController to prevent MDS from doing
        // state restoration for it during initialization, which pretty much messes up the peripheral connection states
        // for good.
        self.mdsWrapper = MDSWrapper(Bundle.main, centralManager: bleController.mdsCentralManager, deviceUUIDs: nil)

        super.init()

        mdsWrapper.delegate = self
        bleController.delegate = self
        subscribeToDeviceConnections()
    }

    func shutdown() {
        mdsWrapper.deactivate()
    }

    /// Start looking for Movesense devices
    func startScan() {
        bleController.startScan()
    }

    /// Stop looking for Movesense devices
    func stopScan() {
        bleController.stopScan()
    }

    /// Establish a connection to the specific Movesense device
    func connectDevice(_ serial: MovesenseSerialNumber) {
        guard let device = movesenseModel?[serial] else {
            delegate?.onControllerError(MovesenseError.controllerError("No such device."))
            return
        }

        guard device.isConnected == false else {
            delegate?.onControllerError(MovesenseError.controllerError("Already connected."))
            return
        }

        delegate?.deviceConnecting(serial)

        mdsWrapper.connectPeripheral(with: device.uuid)
    }

    /// Disconnect specific Movesense device
    func disconnectDevice(_ serial: MovesenseSerialNumber) {
        guard let device = movesenseModel?[serial] else {
            delegate?.onControllerError(MovesenseError.controllerError("No such device."))
            return
        }

        delegate?.deviceDisconnected(device.serialNumber)

        mdsWrapper.disconnectPeripheral(with: device.uuid)
    }

    private func subscribeToDeviceConnections() {
        mdsWrapper.doSubscribe(
            MovesenseConstants.mdsConnectedDevices,
            contract: [:],
            response: { (response) in
                guard response.statusCode == MovesenseResponseCode.ok.rawValue,
                      response.method == MDSResponseMethod.SUBSCRIBE else {
                    NSLog("MovesenseController invalid response to connection subscription.")
                    // TODO: Propagate error
                    return
                }
            },
            onEvent: { [weak self] (event) in
                guard let this = self,
                      let delegate = this.delegate else {
                    NSLog("MovesenseController integrity error.")
                    // TODO: Propagate error
                    return
                }

                // TODO: All decoding needs to be done asynchronously since it may take arbitrary time.
                // TODO: Do it here temporarily.
                guard let decodedEvent = try? this.jsonDecoder.decode(MovesenseDeviceEvent.self,
                                                                      from: event.bodyData) else {
                    let error = MovesenseError.decodingError("MovesenseController: unable to decode device connection response.")
                    NSLog(error.localizedDescription)
                    this.delegate?.onControllerError(error)
                    return
                }

                switch decodedEvent.eventMethod {
                case .post:
                    guard let deviceInfo = decodedEvent.eventBody.deviceInfo,
                          let connectionInfo = decodedEvent.eventBody.connectionInfo else {
                        // TODO: What happens if throw is done here?
                        return
                    }

                    this.mdsWrapper.disableAutoReconnectForDevice(withSerial: deviceInfo.serialNumber)
                    let connection = MovesenseConnection(mdsWrapper: this.mdsWrapper,
                                                         jsonDecoder: this.jsonDecoder,
                                                         connectionInfo: connectionInfo)
                    delegate.deviceConnected(deviceInfo, connection)
                case .del:
                    delegate.deviceDisconnected(decodedEvent.eventBody.serialNumber)
                default:
                    NSLog("MovesenseController::subscribeToDeviceConnections unknown event method.")
                    this.delegate?.onControllerError(MovesenseError.controllerError("Unknown event method"))
                }
            })
    }
}

extension MovesenseController: MovesenseBleControllerDelegate {

    func deviceFound(uuid: UUID, localName: String, serialNumber: String, rssi: Int) {
        let device = MovesenseDeviceConcrete(uuid: uuid, localName: localName,
                                      serialNumber: serialNumber, rssi: rssi)
        delegate?.deviceDiscovered(device)
    }
}

extension MovesenseController: MDSConnectivityServiceDelegate {

    func didFailToConnectWithError(_ error: Error) {
        // NOTE: The error is a null pointer and accessing it will cause a crash
        delegate?.onControllerError(MovesenseError.controllerError("Did fail to connect."))
    }
}
