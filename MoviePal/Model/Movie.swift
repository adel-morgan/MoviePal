//
//  Movie.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import Foundation

struct MovieResult: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let image: String?
    let date: String?
    let score: Double?
    var favorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case image = "poster_path"
        case date = "release_date"
        case score = "vote_average"
    }
}
