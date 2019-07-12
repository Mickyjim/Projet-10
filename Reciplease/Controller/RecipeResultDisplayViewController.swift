//
//  RecipeResultDisplayViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 18/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class RecipeResultDisplayViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    
    let customCellId = "CustomCellId"
    var recipes = [Match]()
    let recipesService = RecipesService()
    var recipeDetails: RecipeDetails?
    var ingredients: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove tableView lines in between each cell
        resultTableView.tableFooterView = UIView()
        
        
        resultTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customCellId)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailedRecipeResultViewController" {
            if let recipeResultDisplayVC = segue.destination as? DetailedRecipeResultViewController {
                recipeResultDisplayVC.recipeDetails = recipeDetails
                recipeResultDisplayVC.ingredients = ingredients
            }
        }
    }
}

// MARK: - Extension enabling UITableView with custom XIB cell
extension RecipeResultDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as? CustomTableViewCell else {
            fatalError("The custom cell does not exist!")
        }
        
        cell.recipe = recipes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipesService.getDetailedRecipes(id: recipes[indexPath.row].id) { (success, recipeDetails) in
            if success {
                guard let recipeDetails = recipeDetails else { return }
                self.recipeDetails = recipeDetails
                self.ingredients = self.recipes[indexPath.row].ingredients
                self.performSegue(withIdentifier: "segueToDetailedRecipeResultViewController", sender: nil)
            }
        }
    }
}


