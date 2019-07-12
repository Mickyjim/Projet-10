//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeRatingsLabel: UILabel!
    @IBOutlet weak var recipeDurationLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    
    var recipe: Match? {
        didSet {
            if let recipe = recipe {
                recipeRatingsLabel.text = "⭐️ " + String(recipe.rating)
                recipeDurationLabel.text = String(recipe.totalTimeInSeconds.timeInSecondsToString)
                
                // Converting an Array of Strings to a chain of characters
                recipeIngredientsLabel.text = recipe.ingredients.joined(separator: ", ")
                
                recipeNameLabel.text = recipe.recipeName
                
                if let data = recipe.smallImageUrls?[0].imageResolutionIncrease.data {
                  recipeImageView.image = UIImage(data: data)
                } else {
                    // Mettre image par défault
                }
            }
        }
    }
    
    var recipeEntity: RecipeEntity? {
        didSet {
            recipeNameLabel.text = recipeEntity?.name
            recipeRatingsLabel.text = recipeEntity?.rating
            recipeDurationLabel.text = recipeEntity?.totalTime
            recipeIngredientsLabel.text = recipeEntity?.id
//            if let imageData = r
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
