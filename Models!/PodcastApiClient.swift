//
//  PodcastApiClient.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct PodcastApiClient {
    
    static func getPodcasts(for searchQuery: String,completion: @escaping (Result<[Podcast],AppError>)->()) {
        
        let searchQuery = searchQuery
        let podcastEndpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        guard let url = URL(string: podcastEndpointURL) else {
            completion(.failure(.badURL(podcastEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                    let podcasts = try JSONDecoder().decode(AllPodCasts.self, from: data)
                    completion(.success(podcasts.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}
