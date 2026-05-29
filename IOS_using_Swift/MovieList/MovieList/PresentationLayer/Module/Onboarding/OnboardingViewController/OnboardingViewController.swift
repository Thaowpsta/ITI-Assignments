//
//  OnboardingViewController.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 05/05/2026.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    

    var arr = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self
        
        // Do any additional setup after loading the view.
        var v1 = self.storyboard?.instantiateViewController(withIdentifier: "v1")
        let v2 = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let service = NetworkService()
        let localDataSource = ProductManager()
        let repository = ProductRepository(networkService: service, localDataSource: localDataSource)
        let useCase = FetchProductsUseCase(repository: repository)
        let viewModel = HomeViewModel(fetchProductsUseCase: useCase)
                
        v2.inject(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: v2)
        
        arr.append(v1!)
        arr.append(navController)
        
        if let firstVC = arr.first{setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)}

    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentInd = arr.firstIndex(of: viewController) else {return nil}
        
        var prev = currentInd - 1
        
        guard prev >= 0 else {return nil}
        
        return arr[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentInd = arr.firstIndex(of: viewController) else {return nil}
        
        var next = currentInd + 1
        
        guard next < arr.count else {return nil}
        
        return arr[next]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arr.count
    }
}
