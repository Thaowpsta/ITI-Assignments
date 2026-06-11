//
//  ViewController.swift
//  Day2
//
//  Created by Thaowpsta Saiid on 01/06/2026.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var debounceButton: UIButton!
    @IBOutlet weak var throttleButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        executeSchedulerTask()
        setupButtonBehaviors()
        applyOperators()
    }

    func getLargeArray() -> [Double] {
        var array: [Double] = []
        for i in 0...1_000_000 {
            array.append(Double(i))
        }
        return array
    }

    func executeSchedulerTask() {
        Observable.just(())
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { _ -> String in
                let array = self.getLargeArray()
                let firstElement = array.first ?? 0.0
                let arrayCount = array.count
                let arraySum = array.reduce(0, +)

                return
                    "First: \(firstElement), Count: \(arrayCount), Sum: \(arraySum)"
            }
            .observe(on: MainScheduler.instance)
            .subscribe { value in
                self.resultLabel.text = value
            }.disposed(by: disposeBag)
    }

    func setupButtonBehaviors() {
        debounceButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { _ in
                print(
                    "Debounce executed"
                )
            }.disposed(by: disposeBag)

        throttleButton.rx.tap
            .throttle(
                .milliseconds(500),
                latest: true,
                scheduler: MainScheduler.instance
            )
            .subscribe { _ in
                print(
                    "Throttle executed"
                )
            }.disposed(by: disposeBag)
    }

    func applyOperators() {
        let observable: Observable<Int> = Observable.of(1,2,3,4,5,6,7,8,9,10)

        //5, 10, 15, 20, 25, 30, 35, 40, 45, 50
        //10, 20, 30, 40, 50
        observable
            .map { $0 * 5 }
            .filter { $0 % 2 == 0 }
            .skip(2)
            .take(10)
            .subscribe { value in
                print(value)
            }.disposed(by: disposeBag)
    }
}
