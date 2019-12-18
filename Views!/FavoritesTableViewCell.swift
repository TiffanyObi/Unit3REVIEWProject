//
//  FavoritesTableViewCell.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var favoritesNameLabel: UILabel!
    
    @IBOutlet weak var favoritesImageView: UIImageView!

    func configureCell(for favorite: Podcast) {
        
        self.backgroundColor = .systemTeal
        
        favoritesNameLabel.text = favorite.collectionName
        
        favoritesImageView.getImage(with: favorite.artworkUrl600) { [weak self](result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.favoritesImageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoritesImageView.image = image
                }
            }
        }
    }

}
