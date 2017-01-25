//
//  Helpers.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}

public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}

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
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            
        }
        
    }
    
}
