//
//  ViewController.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   private var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            DispatchQueue.main.async {
              
                self.loadPodcasts(for: self.searchQuery)
        }
    }
}
    func loadPodcasts(for searchQuery: String) {
        PodcastsAndFavoritesApiClient.getPodcasts(for: searchQuery) { [weak self](result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
                
            case .success(let podcasts):
                DispatchQueue.main.async {
                    self?.podcasts = podcasts
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        loadPodcasts(for:
            "https://itunes.apple.com/search?media=podcast&limit=200&term=swift")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastDetails = segue.destination as? PodcastDetailViewController, let indexpath = tableView.indexPathForSelectedRow else {
            fatalError("could not segue , missing indexPath, questionDC")
        }
        
        let podcast = podcasts[indexpath.row]
        
        podcastDetails.favorited = podcast
    }

}

extension PodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let podcastCell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastTableViewCell else {
             fatalError("couldnt dequeue a Headline Cell")
        }
        
        let podcast = podcasts[indexPath.row]
        
        podcastCell.configureCell(for: podcast)
        
        return podcastCell
    }
}

extension PodcastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension PodcastViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard !(searchBar.text?.isEmpty ?? true) else {
            loadPodcasts(for: "https://itunes.apple.com/search?media=podcast&limit=200&term=swift")
            return
        }
        searchQuery = searchBar.text ?? "Gospel"
    }
}
