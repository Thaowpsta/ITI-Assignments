//
//  ViewController.swift
//  Day9
//
//  Created by Thaowpsta Saiid on 11/05/2026.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.global(qos: .utility).async {
            
            let url = URL(string: "https://m.media-amazon.com/images/M/MV5BNWE4ODBjNDItYTE1MC00ODg1LTg5MzUtZDRkY2ZiZjQyYTgzXkEyXkFqcGdeQXVyMjMxOTE0ODA@._V1_Ratio0.6716_AL_.jpg")
            
            if let data = try? Data(contentsOf: url!),
               let fetchedImage = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.image.image = fetchedImage
                }
            }
        }
        
        testAsyncAndSync()
        testOperationDependencies()
    }
    
    func testAsyncAndSync() {
        let customQueue = DispatchQueue(label: "customSerialQueue")
        
        print("======== Testing Async ========")
        customQueue.async {
            print("Async Task started")
            sleep(2)
            print("Async Task finished")
        }
        print("Returned immediately after calling async\n")
        
        
        print("======== Testing Sync ========")
        customQueue.sync {
            print("Sync Task started")
            sleep(2)
            print("Sync Task finished")
        }
        print("Returned only after calling sync finished\n")
    }
    
    func testOperationDependencies() {
        let operationQueue = OperationQueue()
        
        let downloadOperation = BlockOperation {
            print("1. Downloading image")
            sleep(2)
        }
        
        let filterOperation = BlockOperation {
            print("2. Applying image filter")
            sleep(1)
        }
        
        let displayOperation = BlockOperation {
            OperationQueue.main.addOperation {
                print("3. Displaying image on UI")
            }
        }
        
        
        filterOperation.addDependency(downloadOperation)
        
        displayOperation.addDependency(filterOperation)
        
        
        operationQueue.addOperations([downloadOperation, filterOperation, displayOperation], waitUntilFinished: false)
    }
    
}





