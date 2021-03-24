//
//  MovesenseTypes.swift
//  MovesenseApi
//
//  Copyright © 2019 Movesense. All rights reserved.
//

public typealias MovesenseSerialNumber = String

public enum MovesenseMethod: String, Codable {
    case get = "GET"
    case put = "PUT"
    case del = "DEL"
    case post = "POST"
    case subscribe
    case unsubscribe
}

public enum MovesenseError: Error {
    case integrityError(String)
    case controllerError(String)
    case decodingError(String)
    case requestError(String)
    case deviceError(String)
}

public enum MovesenseResponseCode: Int, Codable {
    case unknown = 0
    case ok = 200
    case created = 201
    case badRequest = 400
    case notFound = 404
    case conflict = 409
}

public struct MovesenseAddressInfo: Codable {

    public let address: String
    public let name: String
}

public struct MovesenseInfo: Codable {

    public let manufacturerName: String
    public let brandName: String?
    public let productName: String
    public let variantName: String
    public let design: String?
    public let hwCompatibilityId: String
    public let serialNumber: String
    public let pcbaSerial: String
    public let swVersion: String
    public let hwVersion: String
    public let additionalVersionInfo: String?
    public let addressInfo: [MovesenseAddressInfo]
    public let apiLevel: String
}

public struct MovesenseDeviceInfo: Codable {

    public let description: String
    public let mode: Int
    public let name: String
    public let serialNumber: String
    public let swVersion: String
    public let hwVersion: String
    public let hwCompatibilityId: String
    public let manufacturerName: String
    public let pcbaSerial: String
    public let productName: String
    public let variantName: String
    public let addressInfo: [MovesenseAddressInfo]
}

public struct MovesenseHeartRate: Codable {

    public let average: Float
    public let rrData: [Int]
}

public struct MovesenseAcc: Codable {

    public let timestamp: UInt32
    public let vectors: [MovesenseVector3D]
}

public struct MovesenseAccConfig: Codable {

    public let gRange: UInt8
}

public struct MovesenseAccInfo: Codable {

    public let sampleRates: [UInt16]
    public let ranges: [UInt8]
}

public struct MovesenseAppInfo: Codable {

    public let name: String
    public let version: String
    public let company: String
}

public struct MovesenseEcg: Codable {

    public let timestamp: UInt32
    public let samples: [Int32]
}

public struct MovesenseEcgInfo: Codable {

    public let currentSampleRate: UInt16
    public let availableSampleRates: [UInt16]
    public let arraySize: UInt16
}

public struct MovesenseGyro: Codable {

    public let timestamp: UInt32
    public let vectors: [MovesenseVector3D]
}

public struct MovesenseGyroConfig: Codable {

    public let dpsRange: UInt16
}

public struct MovesenseGyroInfo: Codable {

    public let sampleRates: [UInt16]
    public let ranges: [UInt16]
}

public struct MovesenseMagn: Codable {

    public let timestamp: UInt32
    public let vectors: [MovesenseVector3D]
}

public struct MovesenseMagnInfo: Codable {

    public let sampleRates: [UInt16]
    public let ranges: [UInt16]
}

public struct MovesenseIMU: Codable {

    public let timestamp: UInt32
    public let accVectors: [MovesenseVector3D]
    public let gyroVectors: [MovesenseVector3D]
}

public struct MovesenseSystemEnergy: Codable {

    public let percentage: UInt8
    public let milliVolts: UInt16?
    public let internalResistance: UInt8?
}

public struct MovesenseSystemMode: Codable {

    let currentMode: UInt8
    let nextMode: UInt8?
}

public struct MovesenseVector3D: Codable {

    public let x: Float
    public let y: Float
    public let z: Float
}
