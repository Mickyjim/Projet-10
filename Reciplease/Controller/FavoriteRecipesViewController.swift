//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {

    
    @IBOutlet weak var savedResultsTableView: UITableView!
    
    let customCellId = "CustomCellId"
    var savedRecipes = [RecipeEntity]()
    var selectedRecipe: RecipeEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Remove tableView lines in between each cell
        savedResultsTableView.tableFooterView = UIView()
        
        savedResultsTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customCellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         savedRecipes = RecipeEntity.fetchAll()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailedRecipeResultViewController" {
            let detailedFavoriteVC = segue.destination as! DetailedFavoriteRecipesViewController
            detailedFavoriteVC.recipeEntity = selectedRecipe
        }
    }
}

// MARK: - Extension for UITableView implementation
extension FavoriteRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as? CustomTableViewCell else {
            fatalError("The custom cell does not exist!")
        }
        
        cell.recipeEntity = savedRecipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return savedRecipes.isEmpty ? 800 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = RecipeEntity.fetchAll()[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailedRecipeResultViewController", sender: nil)
    }
}
