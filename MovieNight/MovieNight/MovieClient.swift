//
//  MovieClient.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

let apiKey = "629dffce2b8a8f3cf597af9e1c49fdcf"

enum MovieDatabase: Endpoint {
    
    case Genre
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .Genre: return "\(baseURL)/genre/movie/list?api_key=\(apiKey)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path)!
        switch self {
        case .Genre: return URLRequest(url: url)
        }
    }
    
}

final class MovieClient: APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: Fetch Genres
    func fetchGenres(_ completion: @escaping (APIResult<[Genre]>) -> Void) {
        let request = MovieDatabase.Genre.request
        
        fetch(request, parse: { (json) -> [Genre]? in
            if let genres = json["genres"] as? [[String : AnyObject]] {
                return genres.flatMap { genreDictionary in
                    return Genre(json: genreDictionary)
                }
            } else {
                return nil
            }
        }, completion: completion)
    }
    
}

