//
//  ViewController.swift
//  Day5
//
//  Created by Thaowpsta Saiid on 04/06/2026.
//

import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var cancellable: AnyCancellable?
    let subject = PassthroughSubject<String, Never>()
    var strictSubscriber: BackPressurSubscriber?

    // 0s for 1, 1s for 2, 2s for 3, 3s for 4, 4s for 5
    let values = [1, 2, 3, 4, 5]
    let delays: [TimeInterval] = [0, 1, 2, 3, 4]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        subjectTask()
                delayTask()
//        testBackPressure()
    }

    private func subjectTask() {
        cancellable =
            subject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.label.text = value
                print("Received on Main Thread: \(value)")
            }

        DispatchQueue.global(qos: .background).async {
            self.subject.send("Hello MAD 46")
        }
    }

    private func delayTask() {
        let values = [1, 2, 3, 4, 5]
        let delays: [TimeInterval] = [0, 1, 2, 3, 4]

        let sequence = zip(values, delays).publisher

        cancellable =
            sequence
            .flatMap(maxPublishers: .max(1)) { value, delay in
                Just(value)
                    .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
            }
            .sink { [weak self] value in
                self?.label.text = "\(value)"
                print("Displayed: \(value)")
            }
    }

    private func testBackPressure() {
        let massivePublisher = (1...10).publisher

        strictSubscriber = BackPressurSubscriber()
        
        if let subscriber = strictSubscriber {
            massivePublisher.subscribe(subscriber)
        }
    }
}
