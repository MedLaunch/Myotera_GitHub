//
// MovesenseMethodParameter.swift
// MovesenseApi
//
// Copyright (c) 2018 Suunto. All rights reserved.
//

import Foundation

protocol MovesenseMethodParameter {
    associatedtype ValueType

    var name: String { get }
    var setter: (ValueType) -> MovesenseRequestParameter { get }
    var values: [ValueType] { get }
    var valueType: ValueType.Type { get }
}

extension MovesenseMethodParameter {

    var valueType: ValueType.Type {
        return ValueType.self
    }
}

struct MovesenseMethodParameterDpsRange: MovesenseMethodParameter {
    typealias ValueType = UInt16

    let name: String = "DPS Range"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.dpsRange
    let values: [ValueType]
}

struct MovesenseMethodParameterIsOn: MovesenseMethodParameter {
    typealias ValueType = Bool

    let name: String = "Is On"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.isOn
    let values: [ValueType] = [true, false]
}

struct MovesenseMethodParameterInterval: MovesenseMethodParameter {
    typealias ValueType = UInt8

    let name: String = "Interval"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.interval
    let values: [ValueType] = []
}

struct MovesenseMethodParameterSampleRate: MovesenseMethodParameter {
    typealias ValueType = UInt

    let name: String = "Sample Rate"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.sampleRate
    let values: [ValueType]
}

struct MovesenseMethodParameterGRange: MovesenseMethodParameter {
    typealias ValueType = UInt8

    let name: String = "G Range"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.gRange
    let values: [ValueType]
}

struct MovesenseMethodParameterSystemMode: MovesenseMethodParameter {
    typealias ValueType = UInt8

    let name: String = "System Mode"
    let setter: (ValueType) -> MovesenseRequestParameter = MovesenseRequestParameter.systemMode
    let values: [ValueType]
}
