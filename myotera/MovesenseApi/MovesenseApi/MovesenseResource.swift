//
// MovesenseResource.swift
// MovesenseApi
//
// Copyright (c) 2018 Suunto. All rights reserved.
//

import Foundation

public enum MovesenseResourceType: String, Codable {

    case acc
    case accConfig
    case accInfo
    case appInfo
    case ecg
    case ecgInfo
    case heartRate
    case gyro
    case gyroConfig
    case gyroInfo
    case magn
    case magnInfo
    case imu
    case info
    case led
    case systemEnergy
    case systemMode
}

public extension MovesenseResourceType {

    var resourcePath: String {
        switch self {
        case .acc: return "Meas/Acc"
        case .accConfig: return "Meas/Acc/Config"
        case .accInfo: return "Meas/Acc/Info"
        case .appInfo: return "Info/App"
        case .ecg: return "Meas/ECG"
        case .ecgInfo: return "Meas/ECG/Info"
        case .heartRate: return "Meas/HR"
        case .gyro: return "Meas/Gyro"
        case .gyroConfig: return "Meas/Gyro/Config"
        case .gyroInfo: return "Meas/Gyro/Info"
        case .magn: return "Meas/Magn"
        case .magnInfo: return "Meas/Magn/Info"
        case .imu: return "Meas/IMU6"
        case .info: return "Info"
        case .led: return "Component/Led"
        case .systemEnergy: return "System/Energy"
        case .systemMode: return "System/Mode"
        }
    }

    var resourceName: String {
        switch self {
        case .acc: return "Linear Acceleration"
        case .accConfig: return "ACC Config"
        case .accInfo: return "ACC Info"
        case .appInfo: return "App Info"
        case .ecg: return "Electrocardiography"
        case .ecgInfo: return "ECG Info"
        case .heartRate: return "Heart Rate"
        case .gyro: return "Gyroscope"
        case .gyroConfig: return "Gyroscope Config"
        case .gyroInfo: return "Gyroscope Info"
        case .magn: return "Magnetometer"
        case .magnInfo: return "Magnetometer Info"
        case .imu: return "IMU"
        case .info: return "Info"
        case .led: return "LED"
        case .systemEnergy: return "System Energy"
        case .systemMode: return "System Mode"
        }
    }

    var resourceAbbreviation: String {
        switch self {
        case .acc: return "ACC"
        case .ecg: return "ECG"
        case .heartRate: return "HRA"
        case .gyro: return "GYR"
        case .magn: return "MAGN"
        case .imu: return "IMU"
        default: return self.resourceName.prefix(3).uppercased()
        }
    }
}

// swiftlint:disable large_tuple
public protocol MovesenseResource {

    var resourceType: MovesenseResourceType { get }
    var methods: [MovesenseMethod] { get }
    var methodParameters: [(MovesenseMethod, String, Any.Type, String)] { get }

    func requestParameter(_ index: Int) -> MovesenseRequestParameter?
}

// Default implementations
public extension MovesenseResource {

    var methodParameters: [(MovesenseMethod, String, Any.Type, String)] { return [] }

    func requestParameter(_ index: Int) -> MovesenseRequestParameter? { return nil }
}

// TODO: The resources could be initialized from the device metadata,
// TODO: for now just specify them here
public struct MovesenseResourceAcc: MovesenseResource {

    internal let sampleRate: MovesenseMethodParameterSampleRate

    public let resourceType: MovesenseResourceType = .acc
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return sampleRate.values.map { rate in
            return (.subscribe, sampleRate.name, sampleRate.valueType, rate.description)
        }
    }

    init(_ sampleRates: [UInt]) {
        self.sampleRate = MovesenseMethodParameterSampleRate(values: sampleRates)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else { return nil }

        switch parameter.2 {
        case is UInt.Type:
            guard let value = UInt(parameter.3) else { return nil }
            return sampleRate.setter(value)
        default: return nil
        }
    }
}

public struct MovesenseResourceAccConfig: MovesenseResource {

    internal let gRange: MovesenseMethodParameterGRange

    public let resourceType: MovesenseResourceType = .accConfig
    public let methods: [MovesenseMethod] = [.get, .put]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return gRange.values.map { range in
            return (.put, gRange.name, gRange.valueType, range.description)
        }
    }

    init(_ gRanges: [UInt8]) {
        self.gRange = MovesenseMethodParameterGRange(values: gRanges)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else {
            return nil
        }

        switch parameter.2 {
        case is UInt8.Type:
            guard let value = UInt8(parameter.3) else { return nil }
            return gRange.setter(value)
        default: return nil
        }
    }
}

public struct MovesenseResourceAccInfo: MovesenseResource {

    public let resourceType: MovesenseResourceType = .accInfo
    public let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceAppInfo: MovesenseResource {

    public let resourceType: MovesenseResourceType = .appInfo
    public let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceEcg: MovesenseResource {

    internal let sampleRate: MovesenseMethodParameterSampleRate

    public let resourceType: MovesenseResourceType = .ecg
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return sampleRate.values.map { rate in
            return (.subscribe, sampleRate.name, sampleRate.valueType, rate.description)
        }
    }

    init(_ sampleRates: [UInt]) {
        self.sampleRate = MovesenseMethodParameterSampleRate(values: sampleRates)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else { return nil }

        switch parameter.2 {
        case is UInt.Type:
            guard let value = UInt(parameter.3) else { return nil }
            return sampleRate.setter(value)
        default: return nil
        }
    }
}

struct MovesenseResourceEcgInfo: MovesenseResource {

    let resourceType: MovesenseResourceType = .ecgInfo
    let methods: [MovesenseMethod] = [.get]
}

struct MovesenseResourceInfo: MovesenseResource {

    let resourceType: MovesenseResourceType = .info
    let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceHeartRate: MovesenseResource {

    public let resourceType: MovesenseResourceType = .heartRate
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]
}

public struct MovesenseResourceGyro: MovesenseResource {

    internal let sampleRate: MovesenseMethodParameterSampleRate

    public let resourceType: MovesenseResourceType = .gyro
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return sampleRate.values.map { rate in
            return (.subscribe, sampleRate.name, sampleRate.valueType, rate.description)
        }
    }

    init(_ sampleRates: [UInt]) {
        self.sampleRate = MovesenseMethodParameterSampleRate(values: sampleRates)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else { return nil }

        switch parameter.2 {
        case is UInt.Type:
            guard let value = UInt(parameter.3) else { return nil }
            return sampleRate.setter(value)
        default: return nil
        }
    }
}


public struct MovesenseResourceGyroConfig: MovesenseResource {

    internal let dpsRange: MovesenseMethodParameterDpsRange

    public let resourceType: MovesenseResourceType = .gyroConfig
    public let methods: [MovesenseMethod] = [.get, .put]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return dpsRange.values.map { range in
            return (.put, dpsRange.name, dpsRange.valueType, range.description)
        }
    }

    init(_ dpsRanges: [UInt16]) {
        self.dpsRange = MovesenseMethodParameterDpsRange(values: dpsRanges)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else {
            return nil
        }

        switch parameter.2 {
        case is UInt16.Type:
            guard let value = UInt16(parameter.3) else { return nil }
            return dpsRange.setter(value)
        default: return nil
        }
    }
}

struct MovesenseResourceGyroInfo: MovesenseResource {

    let resourceType: MovesenseResourceType = .gyroInfo
    let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceMagn: MovesenseResource {

    internal let sampleRate: MovesenseMethodParameterSampleRate

    public let resourceType: MovesenseResourceType = .magn
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return sampleRate.values.map { rate in
            return (.subscribe, sampleRate.name, sampleRate.valueType, rate.description)
        }
    }

    init(_ sampleRates: [UInt]) {
        self.sampleRate = MovesenseMethodParameterSampleRate(values: sampleRates)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else { return nil }

        switch parameter.2 {
        case is UInt.Type:
            guard let value = UInt(parameter.3) else { return nil }
            return sampleRate.setter(value)
        default: return nil
        }
    }
}

struct MovesenseResourceMagnInfo: MovesenseResource {

    let resourceType: MovesenseResourceType = .magnInfo
    let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceIMU: MovesenseResource {

    internal let sampleRate: MovesenseMethodParameterSampleRate

    public let resourceType: MovesenseResourceType = .imu
    public let methods: [MovesenseMethod] = [.subscribe, .unsubscribe]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return sampleRate.values.map { rate in
            return (.subscribe, sampleRate.name, sampleRate.valueType, rate.description)
        }
    }

    init(_ sampleRates: [UInt]) {
        self.sampleRate = MovesenseMethodParameterSampleRate(values: sampleRates)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else { return nil }

        switch parameter.2 {
        case is UInt.Type:
            guard let value = UInt(parameter.3) else { return nil }
            return sampleRate.setter(value)
        default: return nil
        }
    }
}

struct MovesenseResourceLed: MovesenseResource {

    internal let isOn: MovesenseMethodParameterIsOn = MovesenseMethodParameterIsOn()

    let resourceType: MovesenseResourceType = .led
    let methods: [MovesenseMethod] = [.put]

    var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return isOn.values.map { ledOn in
            return (.put, isOn.name, isOn.valueType, ledOn.description)
        }
    }

    func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else {
            return nil
        }

        switch parameter.2 {
        case is Bool.Type:
            guard let value = Bool(parameter.3) else { return nil }
            return isOn.setter(value)
        default: return nil
        }
    }
}

public struct MovesenseResourceSystemEnergy: MovesenseResource {

    public let resourceType: MovesenseResourceType = .systemEnergy
    public let methods: [MovesenseMethod] = [.get]
}

public struct MovesenseResourceSystemMode: MovesenseResource {

    let systemMode: MovesenseMethodParameterSystemMode

    public let resourceType: MovesenseResourceType = .systemMode
    public let methods: [MovesenseMethod] = [.get, .put]

    public var methodParameters: [(MovesenseMethod, String, Any.Type, String)] {
        return systemMode.values.map { mode in
            return (.put, systemMode.name, systemMode.valueType, mode.description)
        }
    }

    init(_ modes: [UInt8]) {
        self.systemMode = MovesenseMethodParameterSystemMode(values: modes)
    }

    public func requestParameter(_ index: Int) -> MovesenseRequestParameter? {
        guard let parameter = methodParameters[safe: index] else {
            return nil
        }

        switch parameter.2 {
        case is UInt8.Type:
            guard let value = UInt8(parameter.3) else { return nil }
            return systemMode.setter(value)
        default: return nil
        }
    }
}
