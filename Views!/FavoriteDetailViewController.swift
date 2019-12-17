//
//  FavoriteDetailViewController.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    @IBOutlet weak var favoritedImageView: UIImageView!
    
    @IBOutlet weak var favoriteNameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var favorite: Favorites!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
   func updateUI() {
    //view.backgroundColor =
    detailLabel.text = "Favorited By: \n \(favorite.favoritedBy)"
        
    favoriteNameLabel.text = "Collection Name: \n \(favorite.collectionName)"
    
    favoritedImageView.getImage(with: favorite.artworkUrl600) {[weak self] (result) in
        switch result {
        case .failure:
            DispatchQueue.main.async {
            self?.favoritedImageView.image = UIImage(systemName: "circle")
        }
        case .success(let image):
            DispatchQueue.main.async {
                self?.favoritedImageView.image = image
            }
        }
    }

}
    
}
