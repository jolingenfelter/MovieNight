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
    
    // MARK: Variables
    var selectedMovies: [Movie] = []
    var user1HasSelected: Bool = false
    var user2HasSelected: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(selectedMovies)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func user1ButtonPressed(sender: UIButton) {
        let genresListViewController = storyboard?.instantiateViewController(withIdentifier: "GenresListViewController") as! GenresListViewController
        self.navigationController?.pushViewController(genresListViewController, animated: true)
    }
    
    @IBAction func user2ButtonPressed(sender: UIButton) {
        
    }
    
    @IBAction func resetSelections(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func viewResults(sender: UIButton) {
        
    }

}

