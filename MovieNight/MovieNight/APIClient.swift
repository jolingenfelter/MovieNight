//
//  APIClient.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

public let TRENetworkingDomainError = "com.jolingenfelter.MovieNight.NetworkingError"
public let MissingHTTPResonse: Int = 10
public let UnexpectedResponseError: Int = 20
public let AbnormalError : Int = 30

typealias json = [String : AnyObject]
typealias jsonTaskCompletion = (json?, HTTPURLResponse?, NSError?) -> Void
typealias jsonTask = URLSessionDataTask

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol jsonDecodable {
    init?(json: [String : AnyObject])
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    init(configuration: URLSessionConfiguration)
}

extension APIClient {
    func jsonTaskWithRequest(_ request: URLRequest, completion: @escaping jsonTaskCompletion) -> jsonTask {
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let HTTPURLResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("MissingHTTPResonse", comment: "")]
                let error = NSError(domain: TRENetworkingDomainError, code: MissingHTTPResonse, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, HTTPURLResponse, error as NSError?)
                }
            } else {
                switch HTTPURLResponse.statusCode {
                case 200:
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: data!, options: []) as? json
                        completion(JSON, HTTPURLResponse, nil)
                    } catch let error as NSError {
                        completion(nil, HTTPURLResponse, error)
                    }
                default: print("Received HTTPResonse: \(HTTPURLResponse.statusCode) - not handled")
                }
            }
    
        })
        
        return task
    }
    
    func fetch<T>(_ request: URLRequest, parse: @escaping(json) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        let task = jsonTaskWithRequest(request) { (json, response, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let abnormalError = NSError(domain: TRENetworkingDomainError, code:AbnormalError, userInfo: nil)
                        completion(.failure(abnormalError))
                    }
                    
                    return
                }
                
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    let error = NSError(domain: TRENetworkingDomainError, code: UnexpectedResponseError, userInfo: nil)
                    completion(.failure(error))
                }
            }
    
        }
        
        task.resume()
    }
}
