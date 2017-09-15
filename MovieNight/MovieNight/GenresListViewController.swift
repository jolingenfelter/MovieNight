//
//  GenresListViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class GenresListViewController: UIViewController {
    
    // MARK: Variables
    let movieClient = MovieClient()
    var genresArray: [Genre]?
    var selectedGenresArray: [Genre] = []
    var numberSelected = 0
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberSelectedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        fetchGenres()
        
        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(connectionErrorAlert), name: NSNotification.Name(rawValue: "ConnectionError"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numberSelectedLabel.text = "\(numberSelected)/5 selected"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ConnectionError"), object: nil)
    }
    
    func nextPressed() {
        let moviesListViewController = storyboard?.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        moviesListViewController.genresArray = selectedGenresArray
        
        if numberSelected != 5 {
            displayAlert(with: "Whoops!", and: "You must choose 5 genres!")
        } else {
            self.navigationController?.pushViewController(moviesListViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: MovieClient 
    
    func fetchGenres() {
        
        movieClient.fetchGenres { (result) in
            
            switch result {
                
                case .success(let genres):
                    self.genresArray = genres
                    self.tableView.reloadData()
                
                
                case .failure(let error): print(error.localizedDescription)
                
                
            }
        }
    }
    
    // MARK: Connection Loss
    
    func connectionErrorAlert() {
        let alert = UIAlertController(title: "No Connection", message: "Movie Night requires a network connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            if let navController = self.navigationController {
                navController.popToRootViewController(animated: true)
            }
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - TableView

extension GenresListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let genresArray = genresArray else {
            return 0
        }
        
        return genresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell") as! GenreTableViewCell
        
        if let genresArray = genresArray {
            let genre = genresArray[indexPath.row]
            cell.genreLabel.text = genre.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if numberSelected >= 5 {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            displayAlert(with: "Whoopsie!", and: "You have already selected 5 genres!")
            
        } else {
            
            guard let genresArray = genresArray else {
                return
            }
            
            let genre = genresArray[indexPath.row]
            selectedGenresArray.append(genre)
            numberSelected += 1
            numberSelectedLabel.text = "\(numberSelected)/5 selected"
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let genresArray = genresArray else {
            return
        }
        
        let genre = genresArray[indexPath.row]
        if let genreToDeselectIndex = selectedGenresArray.index(where: {$0.name == genre.name}) {
            selectedGenresArray.remove(at: genreToDeselectIndex)
        }
        
        numberSelected -= 1
        numberSelectedLabel.text = "\(numberSelected)/5 selected"
    }
    
}

// MARK: - Navigation 

extension GenresListViewController {
    
    func navBarSetup() {
        self.navigationItem.title = "Select Genres"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPressed))
        nextButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.rightBarButtonItem = nextButton
        let backButton = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backPressed))
        backButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func backPressed() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
}
