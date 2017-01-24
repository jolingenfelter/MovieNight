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
    var user1IsSelecting: Bool = false
    var user2IsSelecting: Bool = false
    var user1HasSelected: Bool = false
    var user2HasSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewResultsButton.layer.masksToBounds = true
        viewResultsButton.layer.cornerRadius = 5
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user1IsSelecting = false
        self.user2IsSelecting = false
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
           
            genresListViewController.user1isSelecting = true
            self.navigationController?.pushViewController(genresListViewController, animated: true)
        }
        
    }
    
    @IBAction func user2ButtonPressed(sender: UIButton) {
         let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        if user2HasSelected == true {
            
            presentAlertWithOptions(for: 2)
            
        } else {
            genresListViewController.user2isSelecting = true
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
        
    }
    
    // MARK: Update Selections
    
    func presentAlertWithOptions(for userNumber: Int) {
        
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        let alert = UIAlertController(title: "Whoops!", message: "You have already made your selections.  Are you sure you want to start over?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
            if userNumber == 1 {
                self.user1HasSelected = false
                self.user1Selections = []
                self.updateButtonImages()
                genresListViewController.user1isSelecting = true
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            } else if userNumber == 2 {
                self.user2HasSelected = false
                self.user2Selections = []
                self.updateButtonImages()
                genresListViewController.user2isSelecting = true
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            }
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
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

