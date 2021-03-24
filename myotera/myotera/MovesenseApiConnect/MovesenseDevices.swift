//
//  MovesenseDevices.swift
//  myotera
//
//  Created by Mahmoud Komaiha on 2/25/21.
//

import SwiftUI
import MovesenseApi

enum MovesenseDevicesEvent: ObserverEvent {

    case deviceDiscovered(_ device: DeviceViewModel)
    case deviceStateChanged(_ device: DeviceViewModel)
    case onError(_ error: Error)
    case empty(_ string: String = "No Error")
}

class MovesenseDevices: ObservableObject {

    private var devices: [MovesenseDevice] {
        return Movesense.api.getDevices()
    }
    
    @Published var deviceUpdate: MovesenseDevicesEvent = MovesenseDevicesEvent.empty()
    
    init() {
        Movesense.api.addObserver(self)
    }

    func connectDevice(_ serial: String) {
        guard let device = (devices.first { $0.serialNumber == serial }) else { return }
        Movesense.api.connectDevice(device)
    }

    func disconnectDevice(_ serial: String) {
        guard let device = (devices.first { $0.serialNumber == serial }) else { return }
        Movesense.api.disconnectDevice(device)
    }

    func getConnectedDevices() -> [DeviceViewModel] {
        return devices.filter { $0.isConnected }.map { DeviceViewModel($0) }
    }

    func getActiveDevices() -> [DeviceViewModel] {
        return devices.filter { $0.deviceState != .disconnected }.map { DeviceViewModel($0) }
    }

    func getInactiveDevicesFiltered(_ searchText: String?) -> [DeviceViewModel] {
        guard let searchText = searchText?.lowercased(),
              searchText.isEmpty == false else {
            return devices.filter { $0.deviceState == .disconnected }.map { DeviceViewModel($0) }
        }

        return devices.filter { device in
            device.deviceState == .disconnected &&
            (device.localName.lowercased().contains(searchText) ||
             device.serialNumber.contains(searchText))
        }.map { DeviceViewModel($0) }
    }

    func startDevicesScan() {
        Movesense.api.startScan()
    }

    func stopDevicesScan() {
        Movesense.api.stopScan()
    }

    func resetDevices() {
        Movesense.api.resetScan()
    }
}

extension MovesenseDevices: Observer {

    func handleEvent(_ event: ObserverEvent) {
        guard let event = event as? MovesenseObserverEventApi else { return }

        switch event {
        case .apiDeviceDiscovered(let device): deviceDiscovered(device)
        case .apiDeviceConnecting(let device): deviceConnecting(device)
        case .apiDeviceConnected(let device): deviceConnected(device)
        case .apiDeviceDisconnected(let device): deviceDisconnected(device)
        case .apiDeviceOperationInitiated: return
        case .apiError(let error): onApiError(error)
        }
    }

    func deviceConnecting(_ device: MovesenseDevice) {
        let connectingDevice = DeviceViewModel(device, newState: .connecting)
        self.deviceUpdate = (MovesenseDevicesEvent.deviceStateChanged(connectingDevice))
    }

    func deviceConnected(_ device: MovesenseDevice) {
        let connectedDevice = DeviceViewModel(device, newState: .connected)
        self.deviceUpdate = (MovesenseDevicesEvent.deviceStateChanged(connectedDevice))
    }

    func deviceDisconnected(_ device: MovesenseDevice) {
        let disconnectedDevice = DeviceViewModel(device, newState: .disconnected)
        self.deviceUpdate = (MovesenseDevicesEvent.deviceStateChanged(disconnectedDevice))
    }

    func onDeviceError(_ error: Error, device: MovesenseDevice) {
        let errorDevice = DeviceViewModel(device, newState: .disconnected)
        self.deviceUpdate = (MovesenseDevicesEvent.onError(error))
        self.deviceUpdate = (MovesenseDevicesEvent.deviceStateChanged(errorDevice))
    }

    func deviceDiscovered(_ device: MovesenseDevice) {
        self.deviceUpdate = (MovesenseDevicesEvent.deviceDiscovered(DeviceViewModel(device)))
    }

    func onApiError(_ error: Error) {
        self.deviceUpdate = (MovesenseDevicesEvent.onError(error))
    }
}

