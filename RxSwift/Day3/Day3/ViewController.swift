//
//  ViewController.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 02/06/2026.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    let disposeBag = DisposeBag()

    let personsSubject = PublishSubject<[Person]>()
    var personsArray = [
        Person(firstName: "Esraa", lastName: "Eid"),
        Person(firstName: "Mona", lastName: "Ahmed"),
        Person(firstName: "Ahmed", lastName: "Essam"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        testCombineLatestOperator()
        testReplaySubject()
        setupTableViewWithSubject()
        //        setupTableView()
    }

    func testCombineLatestOperator() {
        let firstObservable = PublishSubject<String>()
        let secondObservable = PublishSubject<String>()

        Observable.combineLatest(firstObservable, secondObservable) {
            first,
            second in
            return "\(first) \(second)"
        }.subscribe(
            onNext: { value in
                print(value)
            },
            onCompleted: {
                print("Completed")
            }
        ).disposed(by: disposeBag)

        firstObservable.onNext("Combine")
        secondObservable.onNext("Latest")
        firstObservable.onNext("Testing Combine")
    }

    func testReplaySubject() {
        let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)

        replaySubject.onNext(1)
        replaySubject.onNext(2)
        replaySubject.onNext(3)

        replaySubject.subscribe(
            onNext: { value in
                print(value)
            },
            onCompleted: {
                print("Completed")
            }
        ).disposed(by: disposeBag)
        replaySubject.onNext(4)
    }

    func setupTableView() {
        myTableView.isEditing = true

        let initialData = [
            Person(firstName: "Esraa", lastName: "Eid"),
            Person(firstName: "Mona", lastName: "Ahmed"),
            Person(firstName: "Ahmed", lastName: "Essam"),
        ]

        let expandedData =
            initialData + [Person(firstName: "Ali", lastName: "Gamal")]

        let personsObservable = Observable<[Person]>.create { observer in
            observer.onNext(initialData)

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                observer.onNext(expandedData)
            }

            return Disposables.create()
        }

        personsObservable
            .bind(to: myTableView.rx.items(cellIdentifier: "cell")) {
                index,
                element,
                cell in
                cell.textLabel?.text = element.fullName
            }.disposed(by: disposeBag)

        myTableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("Item deleted at row: \(indexPath.row)")
        }).disposed(by: disposeBag)

        myTableView.rx.modelDeleted(Person.self).subscribe(onNext: { item in
            print("Model deleted: \(item.fullName)")
        }).disposed(by: disposeBag)
    }

    func setupTableViewWithSubject() {
        myTableView.isEditing = true

        personsSubject
            .bind(to: myTableView.rx.items(cellIdentifier: "cell")) {
                index,
                element,
                cell in
                cell.textLabel?.text = element.fullName
            }.disposed(by: disposeBag)

        personsSubject.onNext(personsArray)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.personsArray.append(
                Person(firstName: "Ali", lastName: "Gamal")
            )
            self.personsSubject.onNext(self.personsArray)
        }

//        myTableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
//            guard let self = self else { return }
//            self.personsArray.remove(at: indexPath.row)
//            self.personsSubject.onNext(self.personsArray)
//            print("Deleted index: \(indexPath.row)")
//        }).disposed(by: disposeBag)

        myTableView.rx.modelDeleted(Person.self).subscribe(onNext: {
            [weak self] deletedPerson in
            guard let self = self else { return }

            if let indexToRemove = self.personsArray.firstIndex(where: {
                $0.fullName == deletedPerson.fullName
            }) {
                self.personsArray.remove(at: indexToRemove)
                self.personsSubject.onNext(self.personsArray)
            }

            print("Model deleted: \(deletedPerson.fullName)")
        }).disposed(by: disposeBag)
    }
}
