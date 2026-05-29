//
//  CollectionViewController.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 04/05/2026.
//

import UIKit
import SDWebImage
import SwiftUI

private let reuseIdentifier = "collectionCell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let imageUrls = [
        "https://picsum.photos/id/10/400/400",
            "https://picsum.photos/id/11/400/400",
            "https://picsum.photos/id/12/400/400",
            "https://picsum.photos/id/13/400/400",
            "https://picsum.photos/id/14/400/400",
            "https://picsum.photos/id/15/400/400",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageUrls.count
    }

        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let totalSpacing: CGFloat = 48
            
            let availableWidth = collectionView.frame.width - totalSpacing
            
            let itemWidth = availableWidth / 2
            
            return CGSize(width: itemWidth, height: itemWidth)
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        if let url = URL(string: imageUrls[indexPath.row]) {
                cell.imageView.sd_setImage(with: url, completed: nil)
            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }


}
