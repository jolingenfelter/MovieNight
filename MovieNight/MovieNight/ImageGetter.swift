//
//  ImageGetter.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 9/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import UIKit

class ImageGetter {
    
    let urlString: String
    let url: URL?
    
    init(urlString: String) {
        self.urlString = urlString
        
        if let url = URL(string: urlString){
            self.url = url
        } else {
            self.url = nil
        }
    }
    
    func getimageDataFromURL(completion: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        guard let url = url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
            }.resume()
        
    }
    
    func getImage(completion: @escaping(_ image: UIImage?) -> Void) {
        
        getimageDataFromURL { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
            
            
        }
        
    }
    
}
