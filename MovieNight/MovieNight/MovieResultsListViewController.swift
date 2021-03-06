//
//  MovieResultsListViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MovieResultsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    var resultsList: [Movie] = []
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        organizeResultsList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()

        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func organizeResultsList() {
        let deDupedArray = resultsList.uniqueElements
        let sortedArray = deDupedArray.sorted { $0.title! < $1.title! }
        resultsList = sortedArray
    }
    
    // MARK: NavBar
    
    func navBarSetup() {
        self.navigationItem.title = "Results"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let backButton = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backPressed))
        backButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backPressed() {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultsCell") as! MovieResultsTableViewCell
        
        let movie = resultsList[indexPath.row]
        
        cell.movieLabel.text = movie.title
        cell.releaseDateLabel.text = movie.releaseDate
        
        // Get MoviePoster
        if let moviePosterURL = movie.moviePosterURL {
            let imageGetter = ImageGetter(urlString: moviePosterURL)
            imageGetter.getImage(completion: { (image) in
                
                DispatchQueue.main.async {
                   cell.movieImage.image = image 
                }
            
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = resultsList[indexPath.row]
        
        let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieResultsDetailViewController!
        movieDetailsVC?.movie = movie
        
        self.navigationController?.pushViewController(movieDetailsVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
