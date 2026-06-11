//
//  ViewController.swift
//  Day1
//
//  Created by Thaowpsta Saiid on 31/05/2026.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {

    //    @IBOutlet weak var mySwitch: UISwitch!
    //    @IBOutlet weak var statusLabel: UILabel!

    let mySwitch = UISwitch()
    let statusLabel = UILabel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProgrammaticUI()

        executeObservableOperators()
        setupSwitchBinding()
    }

    func setupProgrammaticUI() {
        // Configure the label
        statusLabel.text = "Switch is OFF"
        statusLabel.textColor = .black
        statusLabel.textAlignment = .center

        // Disable autoresizing masks so we can use Auto Layout
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add elements to the main view
        view.addSubview(mySwitch)
        view.addSubview(statusLabel)

        // Apply Auto Layout constraints to center them on screen
        NSLayoutConstraint.activate([
            // Center the switch in the middle of the screen
            mySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // Place the label 20 points below the switch
            statusLabel.topAnchor.constraint(
                equalTo: mySwitch.bottomAnchor,
                constant: 20
            ),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func executeObservableOperators() {

        let one = 1
        let two = 2
        let three = 3

        print("--- .just ---")
        let observable: Observable<Int> = Observable<Int>.just(one)

        observable.subscribe(onNext: { value in
            print("Emitted: \(value)")
        }).disposed(by: disposeBag)

        let observable2 = Observable.of(one, two, three)

        observable2.subscribe(onNext: { value in
            print("Emitted: \(value)")
        }).disposed(by: disposeBag)

        print("\n--- .of (Array) ---")
        let observable3 = Observable.of([one, two, three])

        observable3.subscribe(onNext: { value in
            print("Emitted: \(value)")
        }).disposed(by: disposeBag)

        print("\n--- .from ---")
        let observable4 = Observable.from([one, two, three])

        observable4.subscribe(onNext: { value in
            print("Emitted: \(value)")
        }).disposed(by: disposeBag)

        print("\n--- .from ---")
        let observable6 = Observable.from([one, two, three])

        observable6.subscribe(onNext: { value in
            print("Emitted: \(value)")
        }).disposed(by: disposeBag)

        print("\n--- .create ---")
        Observable<String>.create { observer in
            observer.onNext("1")
            observer.onCompleted()
            observer.onNext("?")
            return Disposables.create()
        }
        .subscribe(
            onNext: { value in
                print("Emitted: \(value)")
            },
            onCompleted: {
                print("Completed successfully")
            }
        )
        .disposed(by: disposeBag)
    }

    func setupSwitchBinding() {
        mySwitch.rx.isOn
            .subscribe(onNext: { [weak self] isOn in

                guard let self = self else { return }

                if isOn {
                    print("Switch is ON")
                    self.statusLabel.text = "Switch is ON"
                } else {
                    print("Switch is OFF")
                    self.statusLabel.text = "Switch is OFF"
                }
            })
            .disposed(by: disposeBag)
    }
}
