//
//  PodcastDetailViewController.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var trackCount: UILabel!
    
    @IBOutlet weak var buttonColorChanged: UIButton!
    
    var podcast: Podcast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
   
    @IBAction func favoriteButton(_ sender: UIButton) {
        sender.isEnabled = false
        
        buttonColorChanged.backgroundColor = .systemRed
        
        let favorite = Favorites(trackId: podcast.trackId, favoritedBy: "Tiffany Obi", collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600)
        
        FavoritesApiClient.favoritePodcast(for: favorite) { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "Couldn't Add As Favorite", message: "\(appError)")
            }
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Awesome! We Love That Podcast Too!", message: "\(favorite.collectionName) was posted!")
                }
        }
    }
}
    func updateUI() {
        view.backgroundColor = .systemPurple
        
        podcastNameLabel.text = podcast.collectionName
        
        artistNameLabel.text = podcast.artistName
        
        countryLabel.text = "Country:\(podcast.country)"
        
        trackCount.text = "Track Count: \(podcast.trackCount)"
        imageView.getImage(with: podcast.artworkUrl600) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
}
