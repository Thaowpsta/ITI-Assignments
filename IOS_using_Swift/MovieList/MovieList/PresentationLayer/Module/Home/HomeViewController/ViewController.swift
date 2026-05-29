//
//  ViewController.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 21/05/2026.
//


import UIKit
import NVActivityIndicatorView
import SDWebImage

extension ViewController: AddProductDelegate {
    func addProduct(product: Product) {
        let manager = ProductManager()
        manager.addProduct(product)
            
        viewModel.addProduct(product)
        
        if viewModel.products.first?.title == product.title {
            let topIndexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
        }
    }
}

class ViewController: UITableViewController {
    
    var activityIndicator: NVActivityIndicatorView!
    
    private var viewModel: HomeViewModel!
    
    func inject(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.setupReachability()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        
        activityIndicator = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: 50, height: 50),
            type: .ballSpinFadeLoader,
            color: .systemBlue
        )
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    private func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.showError = { errorMessage in
            print("Catch Error: \(errorMessage)")
        }
    }
    
    @objc func addTapped() {
        let addProductVC = AddProductViewController()
        addProductVC.delegate = self
        navigationController?.pushViewController(addProductVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let product = viewModel.products[indexPath.row]
        cell.titleLabel?.text = product.title
        
        if let thumbnailString = product.thumbnail {
            if thumbnailString.starts(with: "http") {
                if let url = URL(string: thumbnailString) {
                    cell.productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dark_knight_poster"))
                }
            } else {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(thumbnailString)
                
                if let localImage = UIImage(contentsOfFile: fileURL.path) {
                    cell.productImageView.image = localImage
                } else {
                    cell.productImageView.image = UIImage(named: "dark_knight_poster")
                }
            }
        } else {
            cell.productImageView.image = UIImage(named: "dark_knight_poster")
        }
        
        cell.productImageView.layer.cornerRadius = cell.productImageView.frame.width / 2
        cell.productImageView.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = viewModel.products[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.viewModel = ProductDetailViewModel(product: selectedProduct)
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
