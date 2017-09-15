//
//  MovieChoice.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 9/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

protocol MovieChoiceDelegate {
    
    func didChoose(user: User, movies: [Movie])
    func choosingIsComplete()
    
}

class MovieChoice {
    
    let user1 = User(userNumber: 1)
    let user2 = User(userNumber: 2)
    
    var choicesComplete: Bool {
        return user1.hasChosen == true && user2.hasChosen == true
    }
    
    var completeChoicesList: [Movie] {
        var array: [Movie] = []
        array.append(contentsOf: user1.choices)
        array.append(contentsOf: user2.choices)
        return array
    }
    
    var delegate: MovieChoiceDelegate?
    
    func user1IsChoosing() {
        user1.isChoosing = true
        user2.isChoosing = false
    }
    
    func user2IsChoosing() {
        user1.isChoosing = false
        user2.isChoosing = true
    }
    
    func user1DidChoose() {
        user1.isChoosing = false
        user1.hasChosen = true
        delegate?.didChoose(user: user1, movies: user1.choices)
    }
    
    func user2DidChoose() {
        user2.isChoosing = false
        user2.hasChosen = true
        delegate?.didChoose(user: user2, movies: user2.choices)
    }
    
    func choosingIsComplete() {
        delegate?.choosingIsComplete()
    }
    
    func resetChoices() {
        user1.hasChosen = false
        user2.hasChosen = false
        user1.choices.removeAll()
        user2.choices.removeAll()
    }
    
}
