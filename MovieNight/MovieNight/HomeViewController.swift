//
//  ViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/20/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var user1Button: UIButton!
    @IBOutlet weak var user2Button: UIButton!
    @IBOutlet weak var viewResultsButton: UIButton!
    
    // MARK: Variables
    var user1Selections: [Movie] = []
    var user2Selections: [Movie] = []
    
    let movieChoice = MovieChoice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieChoice.delegate = self
        
        viewResultsButton.layer.masksToBounds = true
        viewResultsButton.layer.cornerRadius = 5
        viewResultsButton.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //updateButtonImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    
    @IBAction func user1ButtonPressed(sender: UIButton) {
        
         let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        if movieChoice.user1.hasChosen == true {
            
           presentAlertWithOptions(for: 1)
            
        } else {
           
            movieChoice.user1IsChoosing()
            self.navigationController?.pushViewController(genresListViewController, animated: true)
        }
        
    }
    
    @IBAction func user2ButtonPressed(sender: UIButton) {
        
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        if movieChoice.user2.hasChosen == true {
            
            presentAlertWithOptions(for: 2)
            
        } else {
            
            movieChoice.user2IsChoosing()
            self.navigationController?.pushViewController(genresListViewController, animated: true)
        }
    }
    
    func buttonPressed(forUser: User) {
    
        
    }
    
    @IBAction func resetSelections(sender: UIBarButtonItem) {
        
        movieChoice.resetChoices()
        updateButtonImage(movieChoice.user1)
        updateButtonImage(movieChoice.user2)
        user1Selections = []
        user2Selections = []
    }
    
    @IBAction func viewResults(sender: UIButton) {
        
        if movieChoice.choicesComplete == true {
            
            let resultsListViewController = storyboard?.instantiateViewController(withIdentifier: "MovieResultsListViewController") as! MovieResultsListViewController
            
            resultsListViewController.resultsList.append(contentsOf: user1Selections)
            resultsListViewController.resultsList.append(contentsOf: user2Selections)
            
            self.navigationController?.pushViewController(resultsListViewController, animated: true)
            
        } else {
            
            displayAlert(with: "Whoopsi!", and: "Both users must make selections before you can view the results.")
            
        }
        
    }
    
    // MARK: Alert for reselecting
    
    func presentAlertWithOptions(for userNumber: Int) {
        
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        let alert = UIAlertController(title: "Whoops!", message: "You have already made your selections.  Are you sure you want to start over?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
            if userNumber == 1 {
                self.user1Selections = []
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            } else if userNumber == 2 {
                self.user2Selections = []
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            }
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updateButtonImage(_ user: User) {
        if !user.hasChosen {
            user1Button.setImage(UIImage(named: "bubble-empty"), for: .normal)
        } else {
            user2Button.setImage(UIImage(named: "bubble-selected"), for: .normal)
        }
    }

}

extension HomeViewController: MovieChoiceDelegate {
    
    func didChoose(user: User) {
        
        updateButtonImage(user)
        
    }
    
    func didCancelChoice(user: User) {
        
        updateButtonImage(user)
    }
    
    func choosingIsComplete() {
        viewResultsButton.isEnabled = true
    }
    
}












