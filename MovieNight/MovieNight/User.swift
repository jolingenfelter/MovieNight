//
//  User.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 9/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

class User {
    
    var userNumber: Int
    var isChoosing = false
    var hasChosen = false
    var choices: [Movie] = []
    
    init(userNumber: Int) {
        self.userNumber = userNumber
    }
}

extension User: Equatable {
    final class func ==(lhs: User, rhs: User) -> Bool {
        return lhs.userNumber == rhs.userNumber
    }
}
