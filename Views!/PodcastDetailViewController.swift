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
    
    //var podcast: Podcast!
    var favorited: Podcast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
      
        
    }
    
   
    @IBAction func favoriteButton(_ sender: UIButton) {
        sender.isEnabled = false
        
        buttonColorChanged.backgroundColor = .systemRed
        
        let favorite = Podcast(wrapperType: favorited.wrapperType, kind: favorited.kind, trackId: favorited.trackId, artistName: favorited.artistName, collectionName: favorited.collectionName, artworkUrl600: favorited.artworkUrl600, releaseDate: favorited.releaseDate, trackCount: favorited.trackCount, country: favorited.country, primaryGenreName: favorited.primaryGenreName, artworkUrl100: favorited.artworkUrl100, genres: favorited.genres, favoritedBy: "Tiffany Obi")
        
        PodcastsAndFavoritesApiClient.favoritePodcast(for: favorite) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Couldn't Add As Favorite", message: "\(appError)")
            }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Awesome! We Love That Podcast Too!", message: "\(favorite.collectionName) was posted!")
                }
        }
    }
}
    
    func updateUI() {
        if favorited.favoritedBy != nil {
            buttonColorChanged.isEnabled = false
        }
        view.backgroundColor = .systemPurple
        
        podcastNameLabel.text = favorited.collectionName
        
        artistNameLabel.text = favorited.artistName
        
        countryLabel.text = "Country:\(favorited.country ?? "")"
        
        
        imageView.getImage(with: favorited.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "circle")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    
    
}
