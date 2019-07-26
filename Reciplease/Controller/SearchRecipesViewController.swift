//
//  ViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit
import AVFoundation

class SearchRecipesViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientListInputTableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    @IBAction func addButton(_ sender: Any) {
        guard let textFieldInput = self.textFieldSearch.text else { return }
        ingredientList.append(textFieldInput)
        textFieldSearch.text = ""
        
        /// Creating a comment in the textField after an input to suggest adding another input
        if !ingredientList.isEmpty {
            textFieldSearch.placeholder = "Add another ingredient"
        }
        
        ingredientListInputTableView.reloadData()
    }
    
    @IBAction func snapToClearButton(_ sender: Any) {
        guard let soundURL = Bundle.main.url(forResource: "Snap", withExtension: "mp3") else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        audioPlayer.play()
        ingredientList.removeAll()
        ingredientListInputTableView.reloadData()
        RecipeEntity.deleteAll()
        self.ingredientListInputTableView.reloadData()
        
    }
    
    @IBAction func blendItToSearchButton(_ sender: Any) {
        guard let soundURL = Bundle.main.url(forResource: "Blend", withExtension: "mp3") else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        audioPlayer.play()
        activityIndicator.startAnimating()
        recipesService.getRecipes(ingredients: ingredientList) { (success, recipes) in
            guard success, let recipes = recipes  else {
                self.displayAlert(message: "No recipes found!")
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.recipes = recipes
            self.performSegue(withIdentifier: "segueToRecipeResultDisplay", sender: nil)
        }
    }
    
    // MARK: - Properties
    let recipesService = RecipesService()
    var ingredientList = [String]()
    var recipes = [Match]()
    var audioPlayer : AVAudioPlayer!
    
    // MARK: - View life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipeResultDisplay" {
            if let recipeResultDisplayVC = segue.destination as? RecipeResultDisplayViewController {
                recipeResultDisplayVC.recipes = recipes
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Remove tableView lines in between each cell
        ingredientListInputTableView.tableFooterView = UIView()
        
        /// Keyboard handler implementation
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardHandler))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func keyboardHandler() {
        textFieldSearch.resignFirstResponder()
    }
}

// MARK: - Extension for UITableView implementation
extension SearchRecipesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientInputCell", for: indexPath)
        cell.textLabel?.text = ingredientList[indexPath.row]
        
        return cell
    }
}
