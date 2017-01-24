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

struct Sections {
    var title: String
    var items: [Movie]
    
    init(title: String, items: [Movie]) {
        self.title = title
        self.items = items
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
