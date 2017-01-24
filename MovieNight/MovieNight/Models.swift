//
//  Models.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

// MARK: Genres

struct Genre {
    let id: Int?
    let name: String?
}

extension Genre: jsonDecodable {
    init?(json: [String : AnyObject]) {
        id = json["id"] as? Int
        name = json["name"] as? String
    }
}

// MARK: Movies

struct Movie: Hashable {
    let title: String?
    let releaseDate: String?
    let overview: String?
    let genre: Genre?
    let id: Int?
    var hashValue: Int {
        return self.id!
    }
}

extension Movie: jsonDecodable {
    init?(json: [String : AnyObject]) {
        title = json["title"] as? String
        releaseDate = json["release_date"] as? String
        overview = json["overview"] as? String
        genre = json["genre"] as? Genre
        id = json["id"] as? Int
    }
}
