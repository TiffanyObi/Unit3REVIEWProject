//
//  PodcastTableViewCell.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var podcastImageView: UIImageView!
    
    
    func configureCell(for podcast: Podcast) {
        self.backgroundColor = .cyan
        collectionNameLabel.text = podcast.collectionName
        
       
        genreLabel.text = podcast.primaryGenreName
        
        podcastImageView.getImage(with: podcast.artworkUrl100 ?? "") { [weak self](result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImageView.image = image
                }
            }
        }
    }
}
