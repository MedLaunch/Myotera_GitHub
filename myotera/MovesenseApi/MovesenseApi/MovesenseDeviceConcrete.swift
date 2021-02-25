//
//  MovesenseDeviceConcrete.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

class MovesenseDeviceConcrete: MovesenseDevice {

    private enum Constants {
        static let connectionTimeout: Double = 10.0
    }

    let uuid: UUID
    let localName: String
    let serialNumber: MovesenseSerialNumber
    let rssi: Int

    // TODO: Implement notifications here
    var deviceState: MovesenseDeviceState

    var isConnected: Bool {
        return movesenseConnection != nil
    }

    var deviceInfo: MovesenseDeviceInfo? {
        return movesenseDeviceInfo
    }

    lazy var resources: [MovesenseResource] = deviceResources()

    var observations: [Observation] = [Observation]()
    var observationQueue: DispatchQueue = DispatchQueue.global()

    private var movesenseDeviceInfo: MovesenseDeviceInfo?
    private var movesenseConnection: MovesenseConnection?

    private var connectionTimeout: Timer?

    init(uuid: UUID, localName: String, serialNumber: String, rssi: Int) {
        self.uuid = uuid
        self.localName = localName
        self.serialNumber = serialNumber
        self.rssi = rssi
        self.deviceState = .disconnected
    }

    func sendRequest(_ request: MovesenseRequest,
                            observer: Observer) -> MovesenseOperation? {
        guard let connection = movesenseConnection else {
            let error = MovesenseError.requestError("No connection to device.")
            notifyObservers(MovesenseObserverEventDevice.deviceError(self, error))
            return nil
        }

        let operation = connection.sendRequest(request, serial: self.serialNumber, observer: observer)

        DispatchQueue.global().async { [weak operation] in
            self.notifyObservers(MovesenseObserverEventDevice.deviceOperationInitiated(self, operation: operation))
        }

        return operation
    }

    func sendRequest(_ request: MovesenseRequest,
                            handler: @escaping (MovesenseObserverEventOperation) -> Void) {
        guard movesenseConnection != nil else {
            let error = MovesenseError.requestError("No connection to device.")
            handler(MovesenseObserverEventOperation.operationError(error))
            return
        }

        let responseObserver = MovesenseResponseObserver(handler)
        responseObserver.observedOperation = sendRequest(request, observer: responseObserver)
    }

    func deviceConnecting() {
        deviceState = .connecting
        notifyObservers(MovesenseObserverEventDevice.deviceConnecting(self))

        connectionTimeout = Timer.scheduledTimer(withTimeInterval: Constants.connectionTimeout, repeats: false) { [weak self] _ in
            guard let this = self else { return }

            Movesense.api.disconnectDevice(this)
            let event = MovesenseObserverEventDevice.deviceError(this, MovesenseError.deviceError("Connection timeout."))
            this.notifyObservers(event)
        }
    }

    func deviceConnected(_ deviceInfo: MovesenseDeviceInfo,
                                  _ connection: MovesenseConnection) {
        movesenseDeviceInfo = deviceInfo
        movesenseConnection = connection

        connectionTimeout?.invalidate()
        connectionTimeout = nil

        connection.delegate = self

        deviceState = .connected
        notifyObservers(MovesenseObserverEventDevice.deviceConnected(self))
    }

    func deviceDisconnected() {
        movesenseDeviceInfo = nil
        movesenseConnection = nil

        connectionTimeout?.invalidate()
        connectionTimeout = nil

        deviceState = .disconnected
        notifyObservers(MovesenseObserverEventDevice.deviceDisconnected(self))
    }

    // TODO: Fetch from the actual device
    func deviceResources() -> [MovesenseResource] {
        return [MovesenseResourceAcc([13, 26, 52, 104, 208, 416, 833, 1666]),
                MovesenseResourceAccConfig([2, 4, 8, 16]),
                MovesenseResourceAccInfo(),
                MovesenseResourceAppInfo(),
                MovesenseResourceEcg([128, 256, 512]),
                MovesenseResourceEcgInfo(),
                MovesenseResourceInfo(),
                MovesenseResourceHeartRate(),
                MovesenseResourceGyro([13, 26, 52, 104, 208, 416, 833, 1666]),
                MovesenseResourceGyroConfig([245, 500, 1000, 2000]),
                MovesenseResourceGyroInfo(),
                MovesenseResourceMagn([13, 26, 52, 104, 208, 416, 833, 1666]),
                MovesenseResourceMagnInfo(),
                MovesenseResourceIMU([13, 26, 52, 104, 208, 416, 833, 1666]),
                MovesenseResourceLed(),
                MovesenseResourceSystemEnergy(),
                MovesenseResourceSystemMode([1, 2, 3, 4, 5, 10, 11, 12])]
    }
}

extension MovesenseDeviceConcrete: MovesenseConnectionDelegate {

    func onConnectionError(_ error: Error) {
        notifyObservers(MovesenseObserverEventDevice.deviceError(self, error))
    }
}

private class MovesenseResponseObserver: Observer {

    private var workItem: DispatchWorkItem?
    private var observedOperationEvent: MovesenseObserverEventOperation?

    var observedOperation: MovesenseOperation?

    init(_ handler: @escaping (MovesenseObserverEventOperation) -> Void) {
        // Capture a strong reference to self to prevent deallocation before the operation has finished
        self.workItem = DispatchWorkItem(block: { [self, handler] in
            guard let response = self.observedOperationEvent else { return }

            handler(response)
        })

        self.workItem?.notify(queue: DispatchQueue.global()) { [weak self] in
            // Release workItem which results in deallocation of self
            self?.workItem = nil
        }
    }

    func handleEvent(_ event: ObserverEvent) {
        guard let workItem = workItem else { return }

        if let event = event as? MovesenseObserverEventOperation {
            observedOperationEvent = event
        } else {
            let error = MovesenseError.integrityError("Invalid event observed.")
            observedOperationEvent = MovesenseObserverEventOperation.operationError(error)
        }

        // Execute workItem in the global queue to prevent it from blocking operation event handling
        DispatchQueue.global().async(execute: workItem)
    }
}
