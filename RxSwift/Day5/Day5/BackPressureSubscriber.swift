//
//  BackPressureSubscriber.swift
//  Day5
//
//  Created by Thaowpsta Saiid on 04/06/2026.
//

import Combine
import Foundation

class BackPressurSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never
    
    var subscription: Subscription?
    
    func receive(subscription: Subscription) {
        print("Connected! Requesting the first 2 items...")
//        self.subscription = subscription
        subscription.request(.max(2))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received item: \(input) -> Processing...")
        
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
//            print("Finished processing \(input). Requesting 1 more.")
//            self.subscription?.request(.max(1))
//        }
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Stream completed!")
    }
}
