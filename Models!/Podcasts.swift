//
//  Podcasts.swift
//  Unit3REVIEWProject
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct AllPodCasts: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let wrapperType: String?
    let kind: String?
    let trackId: Double?
    let artistName: String?
    let collectionName: String
    let artworkUrl600: String
    let releaseDate: String?
    let trackCount: Int?
    let country: String?
    let primaryGenreName: String?
    let artworkUrl100: String?
    let genres: [String]?
    let favoritedBy:String?
}

