//
//  Movie.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation


struct Movie: Hashable {
    let title: String?
    let releaseDate: String?
    let overview: String?
    let genre: Genre?
    let id: Int?
    var hashValue: Int {
        return self.id!
    }
    let moviePosterPath: String?
    let moviePosterURL: String?
}

extension Movie: jsonDecodable {
    init?(json: [String : AnyObject]) {
        title = json["title"] as? String
        releaseDate = json["release_date"] as? String
        overview = json["overview"] as? String
        genre = json["genre"] as? Genre
        id = json["id"] as? Int
        moviePosterPath = json["poster_path"] as? String
        
        if let moviePosterPath = moviePosterPath {
            moviePosterURL = "https://image.tmdb.org/t/p/w500\(moviePosterPath)"
        } else {
            moviePosterURL = ""
        }
        
    }
}
