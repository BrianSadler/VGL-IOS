//
//  GameTableViewCell.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/16/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var checkedIn: UIView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
