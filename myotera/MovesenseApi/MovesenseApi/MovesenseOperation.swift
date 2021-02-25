//
//  MovesenseOperation.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

class MovesenseOperationFactory {

    class func create(request: MovesenseRequest,
                      observer: Observer,
                      jsonDecoder: JSONDecoder,
                      onCancel: @escaping () -> Void) -> MovesenseOperationInternal {

        switch request.resourceType {
        case .systemMode: return MovesenseOperationSystemMode(request: request, observer: observer,
                                                              jsonDecoder: jsonDecoder, onCancel: onCancel)

        case .accConfig: return MovesenseOperationAccConfig(request: request, observer: observer,
                                                            jsonDecoder: jsonDecoder, onCancel: onCancel)

        case .gyroConfig: return MovesenseOperationGyroConfig(request: request, observer: observer,
                                                              jsonDecoder: jsonDecoder, onCancel: onCancel)

        default: return MovesenseOperationBase(request: request, observer: observer,
                                               jsonDecoder: jsonDecoder, onCancel: onCancel)
        }
    }
}

protocol MovesenseOperationInternal: MovesenseOperation {

    func handleResponse(status: Int, header: [AnyHashable: Any], data: Data)
    func handleEvent(header: [AnyHashable: Any], data: Data)
}

class MovesenseOperationBase: MovesenseOperationInternal {

    internal var observations: [Observation] = [Observation]()
    private(set) var observationQueue: DispatchQueue

    private let request: MovesenseRequest
    private let onCancel: () -> Void

    private weak var jsonDecoder: JSONDecoder?

    var operationRequest: MovesenseRequest {
        return request
    }

    init(request: MovesenseRequest,
         observer: Observer,
         jsonDecoder: JSONDecoder,
         onCancel: @escaping () -> Void) {
        self.observationQueue = DispatchQueue(label: "com.movesesense.\(request.resourceType.rawValue)", target: .global())
        self.request = request
        self.jsonDecoder = jsonDecoder
        self.onCancel = onCancel
        self.addObserver(observer)
    }

    deinit {
        notifyObservers(MovesenseObserverEventOperation.operationFinished)
        onCancel()
    }

    internal func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        guard let jsonDecoder = self.jsonDecoder else {
            throw MovesenseApiError.operationError("No decoder.")
        }

        return try jsonDecoder.decode(type, from: data)
    }

    // TODO: Only decode responses with success status code
    // swiftlint:disable:next cyclomatic_complexity
    internal func handleResponse(status: Int, header: [AnyHashable: Any], data: Data) {
        //print("Completion status: \(status)\nHeader:\n\(header)\n\(String(data: data, encoding: String.Encoding.utf8))")

        let response: MovesenseResponse?
        switch self.request.resourceType {
        case .accInfo:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseAccInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.accInfo(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                 self.request, decodedResponse.content)
        case .appInfo:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseAppInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.appInfo(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                 self.request, decodedResponse.content)
        case .ecgInfo:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseEcgInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.ecgInfo(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                 self.request, decodedResponse.content)
        case .gyroInfo:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseGyroInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.gyroInfo(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                  self.request, decodedResponse.content)
        case .magnInfo:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseMagnInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.magnInfo(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                  self.request, decodedResponse.content)
        case .info:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseInfo>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.info(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                              self.request, decodedResponse.content)
        case .systemEnergy:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseSystemEnergy>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.systemEnergy(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                      self.request, decodedResponse.content)
        case .systemMode:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseSystemMode>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.systemMode(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                    self.request, decodedResponse.content)
        case .acc, .ecg, .heartRate, .gyro, .magn, .imu, .led:
            response = MovesenseResponse.response(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                  self.request)
        default: response = nil
        }

        if let response = response {
            notifyObservers(MovesenseObserverEventOperation.operationResponse(response))
        } else {
            let error = MovesenseError.decodingError("Unable to decode response.")
            notifyObservers(MovesenseObserverEventOperation.operationError(error))
        }
    }

    internal func handleEvent(header: [AnyHashable: Any], data: Data) {
        //print("Event header:\n\(header)\n\(String(data: data, encoding: String.Encoding.utf8))")

        let event: MovesenseEvent?
        switch self.request.resourceType {
        case .acc:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseAcc>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.acc(self.request, decodedEvent.body)
        case .ecg:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseEcg>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.ecg(self.request, decodedEvent.body)
        case .gyro:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseGyro>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.gyroscope(self.request, decodedEvent.body)
        case .magn:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseMagn>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.magn(self.request, decodedEvent.body)
        case .imu:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseIMU>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.imu(self.request, decodedEvent.body)
        case .heartRate:
            guard let decodedEvent = try? decode(MovesenseEventContainer<MovesenseHeartRate>.self,
                                                 from: data) else {
                event = nil
                break
            }
            event = MovesenseEvent.heartRate(self.request, decodedEvent.body)
        default: event = nil
        }

        if let event = event {
            notifyObservers(MovesenseObserverEventOperation.operationEvent(event))
        } else {
            let error = MovesenseError.decodingError("Unable to decode event.")
            notifyObservers(MovesenseObserverEventOperation.operationError(error))
        }
    }
}

class MovesenseOperationSystemMode: MovesenseOperationBase {

    override func handleResponse(status: Int, header: [AnyHashable: Any], data: Data) {
        //print("Completion status: \(status)\nHeader:\n\(header)\n\(String(data: data, encoding: String.Encoding.utf8))")

        let response: MovesenseResponse?
        switch operationRequest.method {
        case .get:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseSystemMode>.self,
                                                    from: data) else {
                response = nil
                break
            }
            response = MovesenseResponse.systemMode(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                    operationRequest, decodedResponse.content)

        case .put:
            guard let parameter = (operationRequest.parameters?.first),
                  case let MovesenseRequestParameter.systemMode(requestedMode) = parameter else { return }

            response = MovesenseResponse.systemMode(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                    operationRequest, MovesenseSystemMode(currentMode: requestedMode,
                                                                                          nextMode: nil))
        default: response = nil
        }

        if let response = response {
            notifyObservers(MovesenseObserverEventOperation.operationResponse(response))
        } else {
            let error = MovesenseError.decodingError("Unable to decode response.")
            notifyObservers(MovesenseObserverEventOperation.operationError(error))
        }
    }
}

class MovesenseOperationAccConfig: MovesenseOperationBase {

    override func handleResponse(status: Int, header: [AnyHashable: Any], data: Data) {
        //print("Completion status: \(status)\nHeader:\n\(header)\n\(String(data: data, encoding: String.Encoding.utf8))")

        let response: MovesenseResponse?
        switch operationRequest.method {
        case .get:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseAccConfig>.self,
                                                    from: data) else {
                response = nil
                break
            }

            response = MovesenseResponse.accConfig(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                   operationRequest, decodedResponse.content)
        case .put:
            response = MovesenseResponse.accConfig(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                   operationRequest, nil)
        default: response = nil
        }

        if let response = response {
            notifyObservers(MovesenseObserverEventOperation.operationResponse(response))
        } else {
            let error = MovesenseError.decodingError("Unable to decode response.")
            notifyObservers(MovesenseObserverEventOperation.operationError(error))
        }
    }
}

class MovesenseOperationGyroConfig: MovesenseOperationBase {

    override func handleResponse(status: Int, header: [AnyHashable: Any], data: Data) {
        //print("Completion status: \(status)\nHeader:\n\(header)\n\(String(data: data, encoding: String.Encoding.utf8))")

        let response: MovesenseResponse?
        switch operationRequest.method {
        case .get:
            guard let decodedResponse = try? decode(MovesenseResponseContainer<MovesenseGyroConfig>.self,
                                                    from: data) else {
                response = nil
                break
            }

            response = MovesenseResponse.gyroConfig(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                    operationRequest, decodedResponse.content)
        case .put:
            response = MovesenseResponse.gyroConfig(MovesenseResponseCode.init(rawValue: status) ?? .unknown,
                                                    operationRequest, nil)
        default: response = nil
        }

        if let response = response {
            notifyObservers(MovesenseObserverEventOperation.operationResponse(response))
        } else {
            let error = MovesenseError.decodingError("Unable to decode response.")
            notifyObservers(MovesenseObserverEventOperation.operationError(error))
        }
    }
}
