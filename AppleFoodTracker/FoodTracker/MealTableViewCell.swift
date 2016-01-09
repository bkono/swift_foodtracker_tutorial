//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Bryan Konowitz on 1/7/16.
//  Copyright © 2016 Bryan Konowitz. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
