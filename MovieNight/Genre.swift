//
//  Genre.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 9/14/17.
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


