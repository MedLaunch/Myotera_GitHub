//
//  MovesenseCodingKeys.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

extension MovesenseConnectionInfo {

    enum CodingKeys: String, CodingKey {
        case connectionType = "Type"
        case connectionUuid = "UUID"
    }
}

extension MovesenseDeviceInfo {

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case mode = "Mode"
        case name = "Name"
        case serialNumber = "Serial"
        case swVersion = "SwVersion"
        case hwVersion = "hw"
        case hwCompatibilityId = "hwCompatibilityId"
        case manufacturerName = "manufacturerName"
        case pcbaSerial = "pcbaSerial"
        case productName = "productName"
        case variantName = "variant"
        case addressInfo = "addressInfo"
    }
}

extension MovesenseInfo {

    enum CodingKeys: String, CodingKey {
        case manufacturerName = "manufacturerName"
        case brandName = "brandName"
        case productName = "productName"
        case variantName = "variant"
        case design = "design"
        case hwCompatibilityId = "hwCompatibilityId"
        case serialNumber = "serial"
        case pcbaSerial = "pcbaSerial"
        case swVersion = "sw"
        case hwVersion = "hw"
        case addressInfo = "addressInfo"
        case additionalVersionInfo = "additionalVersionInfo"
        case apiLevel = "apiLevel"
    }
}

extension MovesenseDeviceEventBody {

    enum CodingKeys: String, CodingKey {
        case serialNumber = "Serial"
        case connectionInfo = "Connection"
        case deviceInfo = "DeviceInfo"
    }
}

extension MovesenseDeviceEventStatus {

    enum CodingKeys: String, CodingKey {
        case status = "Status"
    }
}

extension MovesenseDeviceEvent {

    enum CodingKeys: String, CodingKey {
        case eventStatus = "Response"
        case eventMethod = "Method"
        case eventUri = "Uri"
        case eventBody = "Body"
    }
}

extension MovesenseHeartRate {

    enum CodingKeys: String, CodingKey {
        case average
        case rrData
    }
}

extension MovesenseEventContainer {

    enum CodingKeys: String, CodingKey {
        case body = "Body"
        case uri = "Uri"
        case method = "Method"
    }
}

extension MovesenseResponseContainer {

    enum CodingKeys: String, CodingKey {
        case content = "Content"
    }
}

extension MovesenseEcgInfo {

    enum CodingKeys: String, CodingKey {
        case currentSampleRate = "CurrentSampleRate"
        case availableSampleRates = "AvailableSampleRates"
        case arraySize = "ArraySize"
    }
}

extension MovesenseEcg {

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case samples = "Samples"
    }
}

extension MovesenseAcc {

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case vectors = "ArrayAcc"
    }
}

extension MovesenseAccConfig {

    enum CodingKeys: String, CodingKey {
        case gRange = "GRange"
    }
}

extension MovesenseAccInfo {

    enum CodingKeys: String, CodingKey {
        case sampleRates = "SampleRates"
        case ranges = "Ranges"
    }
}

extension MovesenseGyro {

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case vectors = "ArrayGyro"
    }
}

extension MovesenseGyroConfig {

    enum CodingKeys: String, CodingKey {
        case dpsRange = "DPSRange"
    }
}

extension MovesenseGyroInfo {

    enum CodingKeys: String, CodingKey {
        case sampleRates = "SampleRates"
        case ranges = "Ranges"
    }
}

extension MovesenseMagn {

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case vectors = "ArrayMagn"
    }
}

extension MovesenseMagnInfo {

    enum CodingKeys: String, CodingKey {
        case sampleRates = "SampleRates"
        case ranges = "Ranges"
    }
}

extension MovesenseIMU {

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case accVectors = "ArrayAcc"
        case gyroVectors = "ArrayGyro"
    }
}

extension MovesenseSystemEnergy {

    enum CodingKeys: String, CodingKey {
        case percentage = "Percent"
        case milliVolts = "MilliVoltages"
        case internalResistance = "InternalResistance"
    }
}

extension MovesenseSystemMode {

    enum CodingKeys: String, CodingKey {
        case currentMode = "current"
        case nextMode = "next"
    }
}
