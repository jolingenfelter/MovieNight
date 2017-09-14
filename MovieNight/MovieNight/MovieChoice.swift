//
//  MovieChoice.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 9/14/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

protocol MovieChoiceDelegate {
    
    func isChoosing(user: User)
    func didChoose(user: User)
    func didCancelChoice(user: User)
    func choosingIsComplete()
    
}

class MovieChoice {
    
    let user1 = User(userNumber: 1)
    let user2 = User(userNumber: 2)
    
    var choicesComplete = false
    
    var delegate: MovieChoiceDelegate?
    
    func user1IsChoosing() {
        user1.isChoosing = true
        user2.isChoosing = false
        delegate?.isChoosing(user: user1)
    }
    
    func user2IsChoosing() {
        user1.isChoosing = false
        user2.isChoosing = true
        delegate?.isChoosing(user: user2)
    }
    
    func user1DidChoose() {
        user1.isChoosing = false
        user1.hasChosen = true
        delegate?.didChoose(user: user1)
    }
    
    func user2Chose() {
        user2.isChoosing = false
        user2.hasChosen = true
        delegate?.didChoose(user: user2)
    }
    
    func user1DidCancel() {
        user1.isChoosing = false
        delegate?.didCancelChoice(user: user1)
    }
    
    func user2DidCancel() {
        user2.isChoosing = false
        delegate?.didCancelChoice(user: user2)
    }
    
    func choosingIsComplete() {
        choicesComplete = true
        delegate?.choosingIsComplete()
    }
    
}
