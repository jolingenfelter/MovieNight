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
        super.viewWillAppear(true)
        sortThroughResults()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func sortThroughResults() {
        let deDupedArray = resultsList.uniqueElements
        let sortedArray = deDupedArray.sorted { $0.title! < $1.title! }
        resultsList = sortedArray
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
