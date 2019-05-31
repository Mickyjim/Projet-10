//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var keywordIngredientLabel: UILabel!
    @IBOutlet weak var ingredientDetailedListLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
