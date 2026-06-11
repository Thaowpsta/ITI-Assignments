//
//  ViewController.swift
//  Day4
//
//  Created by Thaowpsta Saiid on 03/06/2026.
//

import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    var cancellable: AnyCancellable?
    let numbers = [1, 2, 2, 3, 4, 5, 6, 6, 7]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        cancellable = numbers.publisher
            // 2, 2, 4, 6, 6
            .filter { $0 % 2 == 0 }

            // 2, 4, 6
            .removeDuplicates()

            // [2, 4, 6]
            .collect()

            .sink(
                receiveCompletion: { completion in
                    print("Completed: \(completion)")
                },
                receiveValue: { finalArray in
                    print("Final Array: \(finalArray)")
                }
            )

        fetchNews()
    }

    //    func fetchNews() {
    //            guard let url = URL(string: "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json") else { return }
    //
    //            cancellables = URLSession.shared.dataTaskPublisher(for: url)
    //                .map { $0.data }
    //                .decode(type: [News].self, decoder: JSONDecoder())
    //                .receive(on: DispatchQueue.main)
    //                .sink(receiveCompletion: { completion in
    //                    switch completion {
    //                    case .failure(let error):
    //                        print("Error fetching data: \(error.localizedDescription)")
    //                    case .finished:
    //                        print("Network request finished successfully.")
    //                    }
    //                }, receiveValue: { [weak self] newsArray in
    //                    if let firstElement = newsArray.first {
    //                        self?.authorLabel.text = "Author: \(firstElement.author ?? "Unknown")"
    //                        self?.titleLabel.text = "Title: \(firstElement.title ?? "No Title")"
    //
    //                        print("Labels updated with -> Author: \(firstElement.author ?? ""), Title: \(firstElement.title ?? "")")
    //                    }
    //                })
    //        }

    func fetchNews() {
        guard
            let url = URL(
                string:
                    "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json"
            )
        else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [News].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .map { $0.first }
            .receive(on: DispatchQueue.main)
            .assign(to: \.displayNews, on: self)
    }

    var displayNews: News? {
        didSet {
            authorLabel.text = "Author: \(displayNews?.author ?? "Unknown")"
            titleLabel.text = "Title: \(displayNews?.title ?? "No Title")"
            print(
                "Labels updated via assign!\nAuthor: \(displayNews?.author ?? "Unknown")\nTitle: \(displayNews?.title ?? "No Title")"
            )
        }
    }
}
