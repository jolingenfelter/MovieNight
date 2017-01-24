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
    var selectedMovies: [Movie] = []
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
        
        print("user1: \(user1HasSelected)")
        print("user2: \(user2HasSelected)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
    }
    
    @IBAction func viewResults(sender: UIButton) {
        
    }
    
    func presentAlertWithOptions(for userNumber: Int) {
        
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        
        let alert = UIAlertController(title: "Whoops!", message: "You have already made your selections.  Are you sure you want to start over?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
            if userNumber == 1 {
                genresListViewController.user1isSelecting = true
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            } else if userNumber == 2 {
                genresListViewController.user2isSelecting = true
                self.navigationController?.pushViewController(genresListViewController, animated: true)
            }
            
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

