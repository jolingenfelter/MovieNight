//
//  MovieTableViewCell.swift
//  MovieNight
//
//  Created by Joanna Lingenfelter on 1/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if self.isSelected {
            self.checkBox.image = UIImage(named: "selected")
        } else {
            self.checkBox.image = UIImage(named: "notSelected")
        }
    }

}
