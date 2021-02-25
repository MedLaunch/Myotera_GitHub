//
//  MovesenseBleController.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import CoreBluetooth

protocol MovesenseBleControllerDelegate: class {

    func deviceFound(uuid: UUID, localName: String,
                     serialNumber: String, rssi: Int)
}

protocol MovesenseBleController: class {

    var delegate: MovesenseBleControllerDelegate? { get set }

    var mdsCentralManager: CBCentralManager? { get }

    func startScan()
    func stopScan()
}

final class MovesenseBleControllerConcrete: NSObject, MovesenseBleController {

    weak var delegate: MovesenseBleControllerDelegate?

    // Keep this one here to use the same queue with our own central
    private(set) var mdsCentralManager: CBCentralManager?

    private let bleQueue: DispatchQueue

    private var centralManager: CBCentralManager?

    override init() {
        self.bleQueue = DispatchQueue(label: "com.movesense.ble")
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: bleQueue, options: nil)
        mdsCentralManager = CBCentralManager(delegate: self, queue: bleQueue, options: nil)
    }

    func startScan() {
        guard let centralManager = centralManager else {
            NSLog("MovesenseBleController::stopScan integrity error.")
            return
        }

        if centralManager.state != .poweredOn {
            NSLog("MovesenseBleController::startScan Bluetooth not on.")
            return
        }

        centralManager.scanForPeripherals(withServices: Movesense.MOVESENSE_SERVICES,
                                          options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
    }

    func stopScan() {
        guard let centralManager = centralManager else {
            NSLog("MovesenseBleController::stopScan integrity error.")
            return
        }

        if centralManager.state != .poweredOn {
            NSLog("MovesenseBleController::stopScan Bluetooth not on.")
            return
        }

        if centralManager.isScanning == false {
            return
        }

        centralManager.stopScan()
    }

    private func isMovesense(_ localName: String) -> Bool {
        let index = localName.firstIndex(of: " ") ?? localName.endIndex
        return localName[localName.startIndex..<index] == "Movesense"
    }

    private func parseSerial(_ localName: String) -> String? {
        guard isMovesense(localName),
              let idx = localName.range(of: " ", options: .backwards)?.lowerBound else {
            return nil
        }

        return String(localName[localName.index(after: idx)...])
    }
}

extension MovesenseBleControllerConcrete: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case CBManagerState.poweredOff:
            NSLog("centralManagerDidUpdateState: poweredOff")
        case CBManagerState.poweredOn:
            NSLog("centralManagerDidUpdateState: poweredOn")
        default:
            NSLog("centralManagerDidUpdateState: \(central.state.rawValue)")
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any],
                        rssi RSSI: NSNumber) {
        guard let localName = peripheral.name,
              let serialNumber = parseSerial(localName) else {
            return
        }

        delegate?.deviceFound(uuid: peripheral.identifier, localName: localName,
                              serialNumber: serialNumber, rssi: RSSI.intValue)
    }
}
