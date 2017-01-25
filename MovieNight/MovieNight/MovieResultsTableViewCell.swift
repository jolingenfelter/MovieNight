//
//  MovieResultsTableViewCell.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/25/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MovieResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
