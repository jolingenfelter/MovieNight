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
    var user1HasSelected: Bool = false
    var user2HasSelected: Bool = false
    let userDefaults = UserDefaults.standard
    
    let movieChoice = MovieChoice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieChoice.delegate = self
        
        viewResultsButton.layer.masksToBounds = true
        viewResultsButton.layer.cornerRadius = 5
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userDefaults.set(false, forKey: "user1IsSelecting")
        userDefaults.set(false, forKey: "user2IsSelecting")
        
        updateButtonImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    
    @IBAction func user1ButtonPressed(sender: UIButton) {
        
         let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        if user1HasSelected == true {
            
           presentAlertWithOptions(for: 1)
            
        } else {
           
            userDefaults.set(true, forKey: "user1IsSelecting")
            self.navigationController?.pushViewController(genresListViewController, animated: true)
        }
        
    }
    
    @IBAction func user2ButtonPressed(sender: UIButton) {
        
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        if user2HasSelected == true {
            
            presentAlertWithOptions(for: 2)
            
        } else {
            
            userDefaults.set(true, forKey: "user2IsSelecting")
            self.navigationController?.pushViewController(genresListViewController, animated: true)
        }
    }
    
    @IBAction func resetSelections(sender: UIBarButtonItem) {
        user1HasSelected = false
        user2HasSelected = false
        updateButtonImages()
        user1Selections = []
        user2Selections = []
    }
    
    @IBAction func viewResults(sender: UIButton) {
        
        if user1HasSelected == true && user2HasSelected == true {
            
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
                self.user1HasSelected = false
                self.user1Selections = []
                self.updateButtonImages()
                self.userDefaults.set(true, forKey: "user1IsSelecting")
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            } else if userNumber == 2 {
                self.user2HasSelected = false
                self.user2Selections = []
                self.updateButtonImages()
                self.userDefaults.set(true, forKey: "user2IsSelecting")
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            }
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: Update Buttons
    
    func updateButtonImages() {
        
        if user1HasSelected == true{
            user1Button.setImage(UIImage(named: "bubble-selected"), for: .normal)
        } else {
            user1Button.setImage(UIImage(named: "bubble-empty"), for: .normal)
        }
        
        if user2HasSelected == true {
            user2Button.setImage(UIImage(named: "bubble-selected"), for: .normal)
        } else {
            user2Button.setImage(UIImage(named: "bubble-empty"), for: .normal)
        }
    }

}

extension HomeViewController: MovieChoiceDelegate {
    
    func isChoosing(user: User) {
        
    }
    
    func didChoose(user: User) {
        
    }
    
    func didCancelChoice(user: User) {
        
    }
    
    func choosingIsComplete() {
        
    }
    
}












