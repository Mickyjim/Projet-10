//
//  ViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class SearchRecipesViewController: UIViewController {
    
    @IBOutlet weak var ingredientListInputTableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    let recipesService = RecipesService()
    var ingredientList = [String]()
    var recipes = [Match]()
    
    
    @IBAction func addButton(_ sender: Any) {
        guard let textFieldInput = self.textFieldSearch.text else { return }
        ingredientList.append(textFieldInput)
        textFieldSearch.text = ""
        
        // Creating a comment in the textField after an input to suggest adding another input (e.g. "Enter first name", "Enter phone number",...)
        if !ingredientList.isEmpty {
            textFieldSearch.placeholder = "Add another ingredient"
        }
        ingredientListInputTableView.reloadData()
    }
    
    @IBAction func snapToClearButton(_ sender: Any) {
        ingredientList.removeAll()
        ingredientListInputTableView.reloadData()
    }
    
    @IBAction func blendItToSearchButton(_ sender: Any) {
        recipesService.getRecipe(ingredients: ingredientList) { (success, recipes) in
            guard success, let recipes = recipes  else { return }
            self.recipes = recipes
            //performSegue(withIdentifier: "segueToRecipeResultDisplay", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeResultDisplay" {
            let recipeResultDisplayVC = segue.destination as! RecipeResultDisplayViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove tableView lines in between each cell
        ingredientListInputTableView.tableFooterView = UIView()
        
        recipesService.getRecipe(ingredients: ["chicken", "salad"]) { (success, recipes) in
            guard let recipes = recipes else { return }
            print(recipes)
        }
        
        recipesService.getRecipe(ingredients: ["curry", "shrimp"]) { (success, recipes) in
            guard let recipes = recipes else { return }
            print(recipes)
        }
        
    }

}

extension SearchRecipesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientInputCell", for: indexPath)
        cell.textLabel?.text = ingredientList[indexPath.row]
        
        return cell
    }
}
