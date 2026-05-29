//
//  ProductDetailViewController.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 03/05/2026.
//

import Foundation
import SDWebImage
import UIKit

class ProductDetailViewController: UITableViewController {

    var viewModel: ProductDetailViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false

        
        let customNib = UINib(nibName: "CustomCellTableViewCell", bundle: nil)
        tableView.register(customNib, forCellReuseIdentifier: "CustomCell")
        
        if let productToDisplay = viewModel {
            titleLabel.text = productToDisplay.titleText
            descriptionLabel.text = productToDisplay.descriptionText
            categoryLabel.text = "Category: \(productToDisplay.categoryText)"
            priceLabel.text = "Price: $\(productToDisplay.priceText)"
            ratingLabel.text = "Rating: \(productToDisplay.ratingText) / 5.0"
            if let localImage = productToDisplay.image as? UIImage {
                image.image = localImage
            } else if let urlString = productToDisplay.image as? String,
                let url = URL(string: urlString)
            {
                image.sd_setImage(
                    with: url,
                    placeholderImage: UIImage(named: "dark_knight_poster")
                )
            } else {
                image.image = UIImage(named: "dark_knight_poster")
            }
        }
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        if indexPath.row == 6 {
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "CustomCell",
                    for: indexPath
                ) as! CustomCellTableViewCell

            return cell
        }

        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}
