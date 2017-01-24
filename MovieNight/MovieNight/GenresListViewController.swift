//
//  GenresListViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class GenresListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    let movieClient = MovieClient()
    var genresArray: [Genre]?
    var selectedGenresArray: [Genre]?
    var numberSelected = 0
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberSelectedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        fetchGenres()
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: NavigationBar
    
    func navBarSetup() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Select Genres"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPressed))
        nextButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        self.navigationItem.rightBarButtonItem = nextButton
        
    }
    
    func nextPressed() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
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
    
    // MARK: TableViewDelegate
    
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
    
}
