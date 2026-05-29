//
//  HomeViewModel.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 21/05/2026.
//


import Foundation
import Reachability

class HomeViewModel {
    var reloadTableView: (() -> Void)?
    var updateLoadingStatus: ((Bool) -> Void)?
    var showError: ((String) -> Void)?
    
    private let reachability = try! Reachability()
    
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
    
    var products: [Product] = [] {
        didSet { self.reloadTableView?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?(isLoading) }
    }
    
    init(fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func setupReachability() {
        reachability.whenReachable = { [weak self] _ in
            print("Online Mode: Fetching Remote Data")
            self?.fetchRemoteData()
        }
        
        reachability.whenUnreachable = { [weak self] _ in
            print("Offline Mode: Loading Local Core Data")
            self?.loadLocalData()
        }
        
        do { try reachability.startNotifier() } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    private func fetchRemoteData() {
        self.isLoading = true
        
        fetchProductsUseCase.fetchRemote { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedProducts):
                    self?.products = fetchedProducts
                case .failure(let error):
                    self?.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadLocalData() {
        DispatchQueue.main.async {
            self.products = self.fetchProductsUseCase.fetchLocal()
        }
    }
    
    func addProduct(_ product: Product) {
        if reachability.connection == .unavailable {
            products.insert(product, at: 0)
        }
    }
}
