//
//  MovesenseRequest.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

public struct MovesenseRequest {

    public let resourceType: MovesenseResourceType
    public let method: MovesenseMethod
    public let parameters: [MovesenseRequestParameter]?

    public init(resourceType: MovesenseResourceType, method: MovesenseMethod, parameters: [MovesenseRequestParameter]?) {
        self.resourceType = resourceType
        self.method = method
        self.parameters = parameters
    }
}

internal extension MovesenseRequest {

    var contract: [String: Any] {
        let contract = parameters?.reduce([String: Any]()) { (dict, parameter) -> [String: Any] in
            if let parameterTuple = parameter.asContract() {
                var dictCopy = dict
                dictCopy[parameterTuple.0] = parameterTuple.1
                return dictCopy
            }
            return dict
        } ?? [:]

        return contract
    }

    var path: String {
        let pathParameters: String = (parameters?.compactMap { $0.asPath() }.joined()) ?? ""
        return resourceType.resourcePath + pathParameters
    }
}

public enum MovesenseRequestParameter {

    case dpsRange(_ gRange: UInt16)
    case gRange(_ gRange: UInt8)
    case interval(_ interval: UInt8)
    case isOn(_ isOn: Bool)
    case sampleRate(_ rate: UInt)
    case systemMode(_ mode: UInt8)
}

extension MovesenseRequestParameter: CustomStringConvertible {

    public var description: String {
        return "\(name): \(value)"
    }

    public var name: String {
        switch self {
        case .dpsRange: return "DPS Range"
        case .gRange: return "G Range"
        case .interval: return "Interval"
        case .isOn: return "Is On"
        case .sampleRate: return "Sample Rate"
        case .systemMode: return "System Mode"
        }
    }

    public var value: String {
        switch self {
        case .dpsRange(let dpsRange): return "\(dpsRange) deg/s"
        case .gRange(let gRange): return "\(gRange) G"
        case .interval(let interval): return "\(interval)"
        case .isOn(let isOn): return "\(isOn)"
        case .sampleRate(let rate): return "\(rate) Hz"
        case .systemMode(let mode): return "\(mode)"
        }
    }

    func asPath() -> String? {
        switch self {
        case .sampleRate(let rate): return "/\(rate)"
        default: return nil
        }
    }

    func asContract() -> (String, Any)? {
        switch self {
        case .dpsRange(let dpsRange): return ("config", ["DPSRange": dpsRange])
        case .gRange(let gRange): return ("config", ["GRange": gRange])
        case .interval(let interval): return ("Interval", interval)
        case .isOn(let isOn): return ("isOn", isOn)
        case .systemMode(let mode): return ("NewState", mode)
        default: return nil
        }
    }
}
