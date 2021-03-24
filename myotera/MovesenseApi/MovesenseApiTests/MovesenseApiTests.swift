//
//  MovesenseApiTests.swift
//  MovesenseApiTests
//
//  Copyright © 2019 Movesense. All rights reserved.
//

import XCTest
@testable import MovesenseApi

class MovesenseApiTests: XCTestCase {

    var apiEventHandler: ((ObserverEvent) -> Void)?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStartScan() {
        let scanExpectation = self.expectation(description: "scanExpectation")

        apiEventHandler = { event in
            guard event is MovesenseObserverEventApi else { fatalError() }

            scanExpectation.fulfill()
        }

        let model = MovesenseModel()
        let bleControllerMock = MovesenseBleControllerMock()
        let controller = MovesenseController(model: model, bleController: bleControllerMock)

        let api = MovesenseApiConcrete(controller: controller, model: model, bleController: bleControllerMock)

        api.addObserver(self)
        api.startScan()

        wait(for: [scanExpectation], timeout: 5.0)
    }

    func testStopScan() {

    }

    func testResetScan() {

    }
}

extension MovesenseApiTests: Observer {

    func handleEvent(_ event: ObserverEvent) {
        NSLog("handleEvent: \(event)")
        apiEventHandler!(event)
    }
}
