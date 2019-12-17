//
//  FavoritesViewController.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    var favorites = [Favorites]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getFavorites()
        configureRefreshControl()
    }
    

 @objc func getFavorites() {
        FavoritesApiClient.getFavoritesList(){ [weak self](result) in
                switch result {
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                        self?.showAlert(title: "App Error", message: "\(appError)")
                    }
                    
                case .success(let favorites):
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                        self?.favorites = favorites.filter {$0.favoritedBy == "Tiffany Obi"}
                    }
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let favoriteDetails = segue.destination as? FavoriteDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { fatalError("check prepare for segue in favorites controller")
        }
        
        let favoritedPodcast = favorites[indexPath.row]
        
        favoriteDetails.favorite = favoritedPodcast
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        //programmable "target-action" using objective-c runtime.
        refreshControl.addTarget(self, action: #selector(getFavorites), for: .valueChanged)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritesTableViewCell else { fatalError("could not locate Cell")}
        
        let favorited = favorites[indexPath.row]
        
        favoriteCell.configureCell(for: favorited)
        
        return favoriteCell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
