//
//  MovesenseApiConcrete.swift
//  MovesenseApi
//
//  Copyright © 2019 Movesense. All rights reserved.
//

import Foundation

internal class MovesenseApiConcrete: MovesenseApi {

    static let sharedInstance: MovesenseApi = MovesenseApiConcrete()

    internal var observations: [Observation] = [Observation]()
    private(set) var observationQueue: DispatchQueue = DispatchQueue.global()

    private let model: MovesenseModel
    private let controller: MovesenseController

    convenience init() {
        let model = MovesenseModel()
        let bleController = MovesenseBleControllerConcrete()
        let controller = MovesenseController(model: model, bleController: bleController)

        self.init(controller: controller, model: model, bleController: bleController)
    }

    init(controller: MovesenseController, model: MovesenseModel, bleController: MovesenseBleController) {
        self.controller = controller
        self.controller.delegate = model

        self.model = model
        self.model.addObserver(self)
    }

    // MovesenseApiProtocol
    func startScan() {
        controller.startScan()
    }

    func stopScan() {
        controller.stopScan()
    }

    func resetScan() {
        controller.stopScan()
        model.resetDevices()
    }

    func connectDevice(_ device: MovesenseDevice) {
        NSLog("MovesenseApi::connectDevice: \(device.serialNumber)")
        controller.connectDevice(device.serialNumber)
    }

    func disconnectDevice(_ device: MovesenseDevice) {
        NSLog("MovesenseApi::disconnectDevice: \(device.serialNumber)")
        controller.disconnectDevice(device.serialNumber)
    }

    func startObservingDevice(_ device: MovesenseDevice, observer: Observer) {
        NSLog("MovesenseApi::startObservingDevice: \(device.serialNumber)")
        guard let device = model[device.serialNumber] else {
            return
        }

        device.addObserver(observer)
    }

    func stopObservingDevice(_ device: MovesenseDevice, observer: Observer) {
        NSLog("MovesenseApi::stopObservingDevice: \(device.serialNumber)")
        guard let device = model[device.serialNumber] else {
            return
        }

        device.removeObserver(observer)
    }

    func getDevices() -> [MovesenseDevice] {
        return model.map { $0 as MovesenseDevice }
    }

    func getResourcesForDevice(_ device: MovesenseDevice) -> [MovesenseResource]? {
        return model[device.serialNumber]?.resources
    }

    func sendRequestForDevice(_ device: MovesenseDevice, request: MovesenseRequest,
                              observer: Observer) -> MovesenseOperation? {
        return device.sendRequest(request, observer: observer)
    }

    func sendRequestForDevice(_ device: MovesenseDevice, request: MovesenseRequest,
                              handler: @escaping (MovesenseObserverEventOperation) -> Void) {

        device.sendRequest(request, handler: handler)
    }
}

extension MovesenseApiConcrete: Observer {

    internal func handleEvent(_ event: ObserverEvent) {
        switch event {
        case let event as MovesenseObserverEventModel: handleEventModel(event)
        case let event as MovesenseObserverEventDevice: handleEventDevice(event)
        default: assertionFailure("MovesenseApiConcrete::handleEvent: Invalid event.")
        }
    }

    internal func handleEventModel(_ event: MovesenseObserverEventModel) {
        switch event {
        case .deviceDiscovered(let device): deviceDiscovered(device)
        case .modelError(let error): notifyObservers(MovesenseObserverEventApi.apiError(error))
        }
    }

    internal func handleEventDevice(_ event: MovesenseObserverEventDevice) {
        switch event {
        case .deviceConnecting(let device): notifyObservers(MovesenseObserverEventApi.apiDeviceConnecting(device))
        case .deviceConnected(let device): notifyObservers(MovesenseObserverEventApi.apiDeviceConnected(device))
        case .deviceDisconnected(let device): notifyObservers(MovesenseObserverEventApi.apiDeviceDisconnected(device))
        case .deviceOperationInitiated(let device, let operation):
            notifyObservers(MovesenseObserverEventApi.apiDeviceOperationInitiated(device, operation: operation))
        case .deviceError(_, let error): notifyObservers(MovesenseObserverEventApi.apiError(error))
        }
    }

    internal func deviceDiscovered(_ device: MovesenseDevice) {
        device.addObserver(self)
        notifyObservers(MovesenseObserverEventApi.apiDeviceDiscovered(device))
    }
}
