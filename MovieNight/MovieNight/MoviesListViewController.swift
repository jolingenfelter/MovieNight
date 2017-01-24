//
//  MoviesListViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    var genresArray: [Genre]?
    var moviesArray: [Movie]?
    var selectedMoviesArray : [Movie] = []
    var numberSelected = 0
    let movieClient = MovieClient()
    
    // MARK: Outlets
    @IBOutlet weak var numberSelectedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        
        numberSelectedLabel.text = "\(numberSelected)/5 selected"
    
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }
    
    // MARK: Navbar Setup
    
    func navBarSetup() {
        self.navigationItem.title = "Select Movies"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.rightBarButtonItem = doneButton
        let backButton = UIBarButtonItem(title: "< Genres", style: .plain, target: self, action: #selector(backPressed))
        backButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func donePressed() {
        
        if let navController = self.navigationController {
            
            if selectedMoviesArray.count != 5 {
                
                let alert = UIAlertController(title: "Oopsi!", message: "You have not selected 5 movies.  If you proceed all selections will be lost.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in
                    navController.popToRootViewController(animated: true)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                navController.popToRootViewController(animated: true)
            }
        }
    }
    
    func backPressed() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: MovieClient
    
    func fetchMovies() {
        
        guard let genresArray = genresArray else {
            return
        }
        
        var unsortedMoviesArray: [Movie] = []
        
        for genre in genresArray {
            movieClient.fetchMoviesWithGenre(withQuery: genre.id, completion: { (result) in
                switch result {
                case .success(let movies):
                    
                    unsortedMoviesArray.append(contentsOf: movies)
                    let dedupedArray = unsortedMoviesArray.uniqueElements
                    let sortedArray = dedupedArray.sorted { $0.title! < $1.title! }
                    self.moviesArray = sortedArray
                    
                    self.tableView.reloadData()
                
                case .failure(let error): print(error)
                    
                }
            })
        }
        
    }
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let moviesArray = moviesArray else {
            return 0
        }
        
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        if let moviesArray = moviesArray {
            let movie = moviesArray[indexPath.row]
            cell.movieLabel.text = movie.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if numberSelected >= 5 {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            displayAlert(with: "Whoopsie!", and: "You have already selected 5 movies!")
            
        } else {
            
            guard let moviesArray = moviesArray else {
                return
            }
            
            let movie = moviesArray[indexPath.row]
            selectedMoviesArray.append(movie)
            numberSelected += 1
            numberSelectedLabel.text = "\(numberSelected)/5 selected"
            
        }

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let moviesArray = moviesArray else {
            return
        }
        
        let movie = moviesArray[indexPath.row]
        
        if let movieIndex = selectedMoviesArray.index(where: {$0.title == movie.title}) {
            selectedMoviesArray.remove(at: movieIndex)
        }
        
        numberSelected -= 1
        numberSelectedLabel.text = "\(numberSelected)/5 selected"
        
    }

}
