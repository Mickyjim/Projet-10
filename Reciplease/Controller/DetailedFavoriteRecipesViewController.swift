//
//  DetailedFavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class DetailedFavoriteRecipesViewController: UIViewController {
    
    var recipeEntity: RecipeEntity?
    var ingredientLines = [String]()
    var recipeList = [RecipeEntity]()
    
   // MARK - Outlets
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var recipeDurationLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    // MARK -  Actions
    @IBAction func getDirectionsButton(_ sender: Any) {
        guard let recipeEntity = recipeEntity else { return }
        guard let url = URL(string: recipeEntity.sourceUrl ?? "")  else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recipeEntity = recipeEntity else { return }
        recipeRatingLabel.text = "⭐️ " + String(recipeEntity.rating!)
        recipeDurationLabel.text = String(recipeEntity.totalTime!)
        recipeNameLabel.text = recipeEntity.name
//        if let imageUrl = recipeEntity.images[0].hostedLargeUrl {
//            guard let data = imageUrl.data else { return }
//            recipeImageView.image = UIImage(data: data)
//        }
    }
}

// MARK: - Extension for UITableView implementation
extension DetailedFavoriteRecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "ingredientStoredCell", for: indexPath)
        cell.textLabel?.text = ingredientLines[indexPath.row].description
        
        return cell
    }
}
