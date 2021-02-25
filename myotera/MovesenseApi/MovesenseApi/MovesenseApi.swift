//
//  MovesenseApi.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

// Main access point to the API
extension Movesense {

    public static var api: MovesenseApi {
        return MovesenseApiConcrete.sharedInstance
    }
}

public enum MovesenseObserverEventOperation: ObserverEvent {

    case operationResponse(_ response: MovesenseResponse)
    case operationEvent(_ event: MovesenseEvent)
    case operationFinished
    case operationError(_ error: MovesenseError)
}

public protocol MovesenseOperation: Observable {

    var operationRequest: MovesenseRequest { get }
}

public enum MovesenseDeviceState {

    case disconnected
    case connecting
    case connected
}

public enum MovesenseObserverEventDevice: ObserverEvent {

    case deviceConnecting(_ device: MovesenseDevice)
    case deviceConnected(_ device: MovesenseDevice)
    case deviceDisconnected(_ device: MovesenseDevice)
    case deviceOperationInitiated(_ device: MovesenseDevice, operation: MovesenseOperation?)
    case deviceError(_ device: MovesenseDevice, _ error: Error)
}

public protocol MovesenseDevice: Observable {

    var deviceState: MovesenseDeviceState { get }
    var uuid: UUID { get }
    var localName: String { get }
    var serialNumber: MovesenseSerialNumber { get }
    var rssi: Int { get }
    var isConnected: Bool { get }
    var deviceInfo: MovesenseDeviceInfo? { get }
    var resources: [MovesenseResource] { get }

    func sendRequest(_ request: MovesenseRequest,
                     observer: Observer) -> MovesenseOperation?

    func sendRequest(_ request: MovesenseRequest,
                     handler: @escaping (MovesenseObserverEventOperation) -> Void)
}

public enum MovesenseApiError: Error {

    case connectionError(String)
    case initializationError(String)
    case operationError(String)
}

public enum MovesenseObserverEventApi: ObserverEvent {

    case apiDeviceDiscovered(_ device: MovesenseDevice)
    case apiDeviceConnecting(_ device: MovesenseDevice)
    case apiDeviceConnected(_ device: MovesenseDevice)
    case apiDeviceDisconnected(_ device: MovesenseDevice)
    case apiDeviceOperationInitiated(_ device: MovesenseDevice, operation: MovesenseOperation?)
    case apiError(_ error: Error)
}

public protocol MovesenseApi: Observable {

    func startScan()
    func stopScan()
    func resetScan()

    func connectDevice(_ device: MovesenseDevice)
    func disconnectDevice(_ device: MovesenseDevice)

    func startObservingDevice(_ device: MovesenseDevice, observer: Observer)
    func stopObservingDevice(_ device: MovesenseDevice, observer: Observer)

    func getDevices() -> [MovesenseDevice]

    func getResourcesForDevice(_ device: MovesenseDevice) -> [MovesenseResource]?

    func sendRequestForDevice(_ device: MovesenseDevice, request: MovesenseRequest,
                              observer: Observer) -> MovesenseOperation?

    func sendRequestForDevice(_ device: MovesenseDevice, request: MovesenseRequest,
                              handler: @escaping (MovesenseObserverEventOperation) -> Void)
}
