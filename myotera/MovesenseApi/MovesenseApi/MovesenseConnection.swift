//
//  MovesenseConnection.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

protocol MovesenseConnectionDelegate: class {

    func onConnectionError(_ error: Error)
}

class MovesenseConnection {

    private let connectionQueue: DispatchQueue

    private weak var jsonDecoder: JSONDecoder?
    private weak var mdsWrapper: MDSWrapper?

    internal weak var delegate: MovesenseConnectionDelegate?

    init(mdsWrapper: MDSWrapper, jsonDecoder: JSONDecoder, connectionInfo: MovesenseConnectionInfo) {
        self.mdsWrapper = mdsWrapper
        self.jsonDecoder = jsonDecoder
        self.connectionQueue = DispatchQueue(label: "com.movesesense.\(connectionInfo.connectionUuid)", target: .global())
    }

    // TODO: Implement request timeout, although device disconnection handling should cover most of the cases
    // swiftlint:disable:next cyclomatic_complexity
    internal func sendRequest(_ request: MovesenseRequest, serial: String,
                              observer: Observer) -> MovesenseOperation? {
        guard let mds = self.mdsWrapper,
              let jsonDecoder = self.jsonDecoder else {
            let error = MovesenseError.integrityError("MovesenseConnection::sendRequest error.")
            delegate?.onConnectionError(error)
            return nil
        }

        let resourcePath = "\(serial)/\(request.path)"
        let onCancel = {
            switch request.method {
            case .subscribe: mds.doUnsubscribe(resourcePath)
            default: return
            }
        }

        let operation = MovesenseOperationFactory.create(request: request,
                                                         observer: observer,
                                                         jsonDecoder: jsonDecoder,
                                                         onCancel: onCancel)

        // Decode response with the MovesenseOperation instance
        let onCompletion = { [connectionQueue, weak operation] (_ response: MDSResponse) in
            guard let operation = operation else { return }
            connectionQueue.async {
                operation.handleResponse(status: response.statusCode, header: response.header,
                                         data: response.bodyData)
            }
        }

        switch request.method {
        case .get: mds.doGet(resourcePath, contract: request.contract, completion: onCompletion)
        case .put: mds.doPut(resourcePath, contract: request.contract, completion: onCompletion)
        case .post: mds.doPost(resourcePath, contract: request.contract, completion: onCompletion)
        case .del: mds.doDelete(resourcePath, contract: request.contract, completion: onCompletion)
        case .unsubscribe: mds.doUnsubscribe(resourcePath)
        case .subscribe:
            let onEvent = { [connectionQueue, weak operation] (_ event: MDSEvent) in
                guard let operation = operation else {
                    mds.doUnsubscribe(resourcePath)
                    return
                }

                connectionQueue.async {
                    operation.handleEvent(header: event.header,
                                          data: event.bodyData)
                }
            }

            mds.doSubscribe(resourcePath, contract: request.contract,
                            response: onCompletion, onEvent: onEvent)
        }

        return operation
    }
}
