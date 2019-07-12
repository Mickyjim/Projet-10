//
//  DetailedRecipeResultViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 27/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class DetailedRecipeResultViewController: UIViewController {

    // MARK - Outlets
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var recipeDurationLabel: UILabel!
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    // MARK - Actions
    
    @IBAction func getDirectionsButton(_ sender: Any) {
        guard let recipeDetails = recipeDetails else { return }
        guard let url = URL(string: recipeDetails.source.sourceRecipeUrl)  else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // Saving favorite recipes
    @IBAction func addFavoriteButton(_ sender: Any) {
        guard let recipeDetails = recipeDetails else { return }
        if RecipeEntity.isRegistered(id: recipeDetails.id) {
            RecipeEntity.delete(id: recipeDetails.id)
            print(RecipeEntity.fetchAll())
        } else {
            guard let ingredients = ingredients else { return }
            RecipeEntity.add(recipeDetails: recipeDetails, ingredients: ingredients)
            print(RecipeEntity.fetchAll())
        }
    }
    
    
    var recipeDetails: RecipeDetails?
    var ingredients: [String]?
    var recipeList = RecipeEntity.fetchAll()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let recipeDetails = recipeDetails else { return }
        recipeRatingLabel.text = "⭐️ " + String(recipeDetails.rating)
        recipeDurationLabel.text = String(recipeDetails.totalTimeInSeconds.timeInSecondsToString)
        recipeNameLabel.text = recipeDetails.name
        if let imageUrl = recipeDetails.images[0].hostedLargeUrl {
            guard let data = imageUrl.data else { return }
            recipeImageView.image = UIImage(data: data)
        }
    }
}

extension DetailedRecipeResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeDetails = recipeDetails else { return 0 }
        return recipeDetails.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientInputCell", for: indexPath)
        cell.textLabel?.text = recipeDetails?.ingredientLines[indexPath.row]
        
        return cell
    }
}
