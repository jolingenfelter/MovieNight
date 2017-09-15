//
//  MovieResultsDetailViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MovieResultsDetailViewController: UIViewController {
    
    
    // MARK: Variables
    var movie: Movie?
    
    // MARK: Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDescriptionTextField: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        viewSetup()
    }
    
    // MARK: NavBar
    
    func navBarSetup() {
        self.navigationItem.title = "Results"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backButton = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backPressed))
        backButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func backPressed() {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: View

    
    func viewSetup() {
        guard let movie = movie else {
            return
        }
        
        if let movieOverView = movie.overview {
            movieDescriptionTextField.text = movieOverView
        } else {
            movieDescriptionTextField.text = "No description available"
        }
        
        if let movieReleaseDate = movie.releaseDate {
            releaseDateLabel.text = movieReleaseDate
        }
        
        if let moviePosterURL = movie.moviePosterURL {
            let imageGetter = ImageGetter(urlString: moviePosterURL)
            imageGetter.getImage(completion: { (image) in
                self.moviePosterImageView.image = image
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func finshPressed(sender: UIButton) {
        let homeViewController = navigationController?.viewControllers[0] as! HomeViewController
        homeViewController.movieChoice.resetChoices()
        
        if let navController = navigationController {
            navController.popToRootViewController(animated: true)
        }
    }
}
