//
//  Observer.swift
//  MovesenseApi
//
//  Copyright © 2018 Suunto. All rights reserved.
//

import Foundation

public protocol ObserverEvent {}

public protocol Observer: class {

    func handleEvent(_ event: ObserverEvent)
}

extension Observer {

    func handleEvent(_ event: ObserverEvent) {
        assertionFailure("Observer::handleEvent not implemented.")
    }
}

public struct Observation {

    weak var observer: Observer?
}

public protocol Observable: class {

    var observations: [Observation] { get set }
    var observationQueue: DispatchQueue { get }

    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers(_ event: ObserverEvent)
}

public extension Observable {

    func addObserver(_ observer: Observer) {
        guard (observations.contains { $0.observer === observer } == false) else {
            NSLog("Observable::addObserver: Observer added already.")
            return
        }

         DispatchQueue.global().sync {
            observations.append(Observation(observer: observer))
        }
    }

    func removeObserver(_ observer: Observer) {
        DispatchQueue.global().sync {
            observations = observations.filter {
                ($0.observer != nil) && ($0.observer !== observer)
            }
        }
    }

    func notifyObservers(_ event: ObserverEvent) {
        observationQueue.async { [observations] in
            observations.compactMap { $0.observer }.forEach { $0.handleEvent(event) }
        }
    }
}
