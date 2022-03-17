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

class PublishSubject<Output: Any, Failure: Error> {

    let subject: PassthroughSubject<Output, Failure>
    let subscriber: SubscriberFaultWrapper<Output, Failure>

    init(demand: Subscribers.Demand = .unlimited, modifier: Subscribers.Demand = .none) {
        self.subject = PassthroughSubject()
        self.subscriber = SubscriberFaultWrapper(demand: demand, modifier: modifier)
    }

    func sink(_ receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void), receiveValue: @escaping ((Output) -> Void)) -> AnyCancellable {
        subject.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
    }
}

class BehaviorSubject<Output: Any, Failure: Error> {
    let subject: CurrentValueSubject<Output, Failure>
    let subscriber: SubscriberFaultWrapper<Output, Failure>

    init(demand: Subscribers.Demand = .unlimited, modifier: Subscribers.Demand = .none, initialValue value: Output) {
        self.subject = CurrentValueSubject(value)
        self.subscriber = SubscriberFaultWrapper(demand: demand, modifier: modifier)
    }

    func sink(_ receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void), receiveValue: @escaping ((Output) -> Void)) -> AnyCancellable {
        subject.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
    }
}

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
