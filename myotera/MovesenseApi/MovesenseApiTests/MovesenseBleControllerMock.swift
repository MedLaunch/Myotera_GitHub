//
//  MovesenseBleControllerMock.swift
//  MovesenseApiTests
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import CoreBluetooth
import Foundation

@testable import MovesenseApi

class MovesenseBleControllerMock: MovesenseBleController {

    var delegate: MovesenseBleControllerDelegate?
    private(set) var mdsCentralManager: CBCentralManager?

    func startScan() {
        self.delegate?.deviceFound(uuid: UUID(), localName: "Foo 123", serialNumber: "123", rssi: 0)
    }

    func stopScan() {

    }
}
