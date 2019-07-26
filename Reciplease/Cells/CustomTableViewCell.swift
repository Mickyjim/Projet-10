//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeRatingsLabel: UILabel!
    @IBOutlet weak var recipeDurationLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    // MARK: - Properties
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
                }
            }
        }
    }
    
    var recipeEntity: RecipeEntity? {
        didSet {
            guard let recipeEntity = recipeEntity else { return }
            recipeNameLabel.text = recipeEntity.name
            recipeRatingsLabel.text = "⭐️ " + (recipeEntity.rating ?? "")
            recipeDurationLabel.text = recipeEntity.totalTime
            let ingredientEntities = recipeEntity.ingredients?.allObjects as! [IngredientEntity]
            let ingredientsFormated = ingredientEntities.map({$0.name ?? ""}).joined(separator: ", ")
            recipeIngredientsLabel.text = ingredientsFormated
            if let imageData = recipeEntity.imageData {
                recipeImageView.image = UIImage(data: imageData)
            }
        }
    }
}
