//
//  MovieResultsListViewController.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MovieResultsListViewController: UIViewController {
    
    // MARK: Variables
    var resultsList: [Movie] = []
    
    //MARK: Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        sortThroughResults()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
