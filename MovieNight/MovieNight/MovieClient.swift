//
//  MovieClient.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import UIKit


enum MovieDatabase: Endpoint {
    
    case Genres
    case Movies
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    private var apiKey: String {
        return "629dffce2b8a8f3cf597af9e1c49fdcf"

    }
    
    func createURL(withQuery query: Int?) -> URL {
        
        switch self {
            
            case .Genres:
            
                return URL(string: "\(baseURL)/genre/movie/list?api_key=\(apiKey)")!
            
            case .Movies:
            
                return URL(string: "\(baseURL)/genre\(query!)/movies?api_key=\(apiKey)")!
            
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
    func fetchGenres(completion: @escaping (APIResult<[Genre]>) -> Void) {
        
        let url = MovieDatabase.Genres.createURL(withQuery: nil)
        
        let request = URLRequest(url: url)
        
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
    
    // MARK: Fetch Movies
    func fetchMoviesWithGenre(withQuery query: Int?, completion: @escaping (APIResult<[Movie]>) -> Void) {
        
        let url = MovieDatabase.Movies.createURL(withQuery: query)
        let request = URLRequest(url: url)
        
        fetch(request, parse: { (json) -> [Movie]? in
            
            if let movies = json["results"] as? [[String : AnyObject]] {
                
                return movies.flatMap { movieDictionary in
                    
                    return Movie(json: movieDictionary)
                    
                }
                
            } else {
                return nil
            }
            
        }, completion: completion)
    }
    

}
