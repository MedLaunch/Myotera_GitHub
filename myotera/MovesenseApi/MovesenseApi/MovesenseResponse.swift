//
//  MovesenseResponse.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

// Request responses
public enum MovesenseResponse {

    case accConfig(MovesenseResponseCode, MovesenseRequest, MovesenseAccConfig?)
    case accInfo(MovesenseResponseCode, MovesenseRequest, MovesenseAccInfo)
    case appInfo(MovesenseResponseCode, MovesenseRequest, MovesenseAppInfo)
    case ecgInfo(MovesenseResponseCode, MovesenseRequest, MovesenseEcgInfo)
    case gyroConfig(MovesenseResponseCode, MovesenseRequest, MovesenseGyroConfig?)
    case gyroInfo(MovesenseResponseCode, MovesenseRequest, MovesenseGyroInfo)
    case magnInfo(MovesenseResponseCode, MovesenseRequest, MovesenseMagnInfo)
    case info(MovesenseResponseCode, MovesenseRequest, MovesenseInfo)
    case response(MovesenseResponseCode, MovesenseRequest)
    case systemEnergy(MovesenseResponseCode, MovesenseRequest, MovesenseSystemEnergy)
    case systemMode(MovesenseResponseCode, MovesenseRequest, MovesenseSystemMode)
}

extension MovesenseResponse: CustomStringConvertible {

    public var description: String {
        switch self {
        case .accConfig(let code, _, let config): return "\(code), \(String(describing: config))"
        case .accInfo(let code, _, let info): return "\(code), \((info))"
        case .appInfo(let code, _, let info): return "\(code), \((info))"
        case .ecgInfo(let code, _, let info): return "\(code), \((info))"
        case .gyroConfig(let code, _, let config): return "\(code), \(String(describing: config))"
        case .gyroInfo(let code, _, let info): return "\(code), \((info))"
        case .magnInfo(let code, _, let info): return "\(code), \((info))"
        case .info(let code, _, let info): return "\(code), \(info)"
        case .response(let code, _): return "\(code)"
        case .systemEnergy(let code, _, let energy): return "\(code), \(String(describing: energy))"
        case .systemMode(let code, _, let mode): return "\(code), \(String(describing: mode))"
        }
    }
}
