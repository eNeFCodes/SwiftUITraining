//
//  ScrubWrapper.swift
//  SwiftUITraining
//
//  Created by Neil Francis Hipona on 3/9/22.
//

import Foundation
import Combine

// PassthroughSubject <-> PublishSubject
// CurrentValueSubject <-> BehaviorSubject

class SubscriberFaultWrapper<InputType: Any, FailureType: Error>: Subscriber {

    private let demand: Subscribers.Demand
    private let modifier: Subscribers.Demand

    init(demand: Subscribers.Demand = .unlimited, modifier: Subscribers.Demand = .none) {
        self.demand = demand
        self.modifier = modifier
    }

    func receive(subscription: Subscription) {
        subscription.request(demand)
    }

    func receive(_ input: InputType) -> Subscribers.Demand {
        return modifier
    }

    func receive(completion: Subscribers.Completion<FailureType>) {

    }
}

class SubscriberWrapper<InputType: Any>: Subscriber {

    private let demand: Subscribers.Demand
    private let modifier: Subscribers.Demand

    init(demand: Subscribers.Demand = .unlimited, modifier: Subscribers.Demand = .none) {
        self.demand = demand
        self.modifier = modifier
    }

    func receive(subscription: Subscription) {
        subscription.request(demand)
    }

    func receive(_ input: InputType) -> Subscribers.Demand {
        return modifier
    }

    func receive(completion: Subscribers.Completion<Never>) {

    }
}
