//
//  MovesenseModel.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

enum MovesenseConstants {

    static let mdsConnectedDevices = "MDS/ConnectedDevices"
}

struct MovesenseEventContainer<T: Decodable>: Decodable {

    let body: T
    let uri: String
    let method: String
}

struct MovesenseResponseContainer<T: Decodable>: Decodable {

    let content: T
}

struct MovesenseConnectionInfo: Codable {

    let connectionType: String
    let connectionUuid: UUID
}

struct MovesenseDeviceEventBody: Codable {

    let serialNumber: String
    let connectionInfo: MovesenseConnectionInfo?
    let deviceInfo: MovesenseDeviceInfo?
}

struct MovesenseDeviceEventStatus: Codable {

    let status: MovesenseResponseCode
}

struct MovesenseDeviceEvent: Codable {

    let eventUri: String
    let eventStatus: MovesenseDeviceEventStatus
    let eventMethod: MovesenseMethod
    let eventBody: MovesenseDeviceEventBody
}

enum MovesenseObserverEventModel: ObserverEvent {

    case deviceDiscovered(_ device: MovesenseDevice)
    case modelError(_ error: Error)
}

class MovesenseModel: Observable {

    typealias ArrayType = [MovesenseDeviceConcrete]

    internal var observations: [Observation] = [Observation]()
    private(set) var observationQueue: DispatchQueue = DispatchQueue.global()

    private var devices: [MovesenseDeviceConcrete] = [MovesenseDeviceConcrete]()

    subscript(serial: MovesenseSerialNumber) -> MovesenseDevice? {
        return self.first { $0.serialNumber == serial }
    }

    func resetDevices() {
        observationQueue.sync {
            devices.removeAll { $0.deviceState == .disconnected }
        }
    }
}

// Collection protocol for hiding the actual data storage
extension MovesenseModel: Collection {

    typealias Index = ArrayType.Index
    typealias Element = ArrayType.Element

    var startIndex: Index { return devices.startIndex }
    var endIndex: Index { return devices.endIndex }

    subscript(index: Index) -> Element {
        return devices[index]
    }

    func index(after i: Index) -> Index {
        return devices.index(after: i)
    }
}

extension MovesenseModel: MovesenseControllerDelegate {

    func deviceDiscovered(_ device: MovesenseDeviceConcrete) {
        guard (self.contains { $0.serialNumber == device.serialNumber }) == false else {
            return
        }

        observationQueue.sync {
            devices.append(device)
            notifyObservers(MovesenseObserverEventModel.deviceDiscovered(device))
        }
    }

    func deviceConnecting(_ serialNumber: MovesenseSerialNumber) {
        guard let device = (self.first { $0.serialNumber == serialNumber }) else {
            let error = MovesenseError.integrityError("No such device for connecting.")
            notifyObservers(MovesenseObserverEventModel.modelError(error))
            return
        }

        device.deviceConnecting()
    }

    func deviceConnected(_ deviceInfo: MovesenseDeviceInfo,
                         _ connection: MovesenseConnection) {
        guard let device = (self.first { $0.serialNumber == deviceInfo.serialNumber }) else {
            let error = MovesenseError.integrityError("No such connected device.")
            notifyObservers(MovesenseObserverEventModel.modelError(error))
            return
        }

        device.deviceConnected(deviceInfo, connection)
    }

    func deviceDisconnected(_ serialNumber: String) {
        guard let device = (self.first { $0.serialNumber == serialNumber }) else {
            let error = MovesenseError.integrityError("No such disconnected device.")
            notifyObservers(MovesenseObserverEventModel.modelError(error))
            return
        }

        device.deviceDisconnected()
    }

    func onControllerError(_ error: Error) {
        notifyObservers(MovesenseObserverEventModel.modelError(error))
    }
}
