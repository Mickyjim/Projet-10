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
    
    // MARK - Outlets
    @IBOutlet weak var recipeRatingLabel: UILabel!
    @IBOutlet weak var recipeDurationLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    // MARK -  Actions
    @IBAction func getDirectionsButton(_ sender: Any) {
        guard let recipeEntity = recipeEntity else { return }
        guard let url = URL(string: recipeEntity.sourceUrl ?? "")  else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        guard let recipeEntity = recipeEntity else { return }
        RecipeEntity.delete(id: recipeEntity.id ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.tintColor = .purple
        guard let recipeEntity = recipeEntity else { return }
        recipeRatingLabel.text = "⭐️ " + String(recipeEntity.rating ?? "")
        recipeDurationLabel.text = String(recipeEntity.totalTime ?? "")
        recipeNameLabel.text = recipeEntity.name
        if let imageData = recipeEntity.imageData {
            recipeImageView.image = UIImage(data: imageData)
        }
    }
}

// MARK: - Extension for UITableView implementation
extension DetailedFavoriteRecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredientLines = recipeEntity?.ingredientLines?.allObjects as? [IngredientLineEntity]
        return ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "ingredientInputCell", for: indexPath)
        guard let recipeEntity = recipeEntity else { return UITableViewCell() }
        let ingredientLines = recipeEntity.ingredientLines?.allObjects as! [IngredientLineEntity]
        let ingredientLine = ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredientLine.name
        
        return cell
    }
}
