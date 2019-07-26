//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 30/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var savedResultsTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let customCellId = "CustomCellId"
    private var savedRecipes = [RecipeEntity]()
    private var selectedRecipe: RecipeEntity?
    
    private lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        /// Remove tableView lines in between each cell
        savedResultsTableView.tableFooterView = UIView()
        
        savedResultsTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customCellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedRecipes = RecipeEntity.fetchAll()
        savedResultsTableView.reloadData()
    }
    
    // MARK: - Class methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailedFavoriteRecipesViewController" {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = RecipeEntity.fetchAll()[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailedFavoriteRecipesViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let message = UILabel()
        message.text = "Add some recipes to your favorite recipe list"
        message.textAlignment = .center
        message.textColor = UIColor(red: 67/255, green: 4/255, blue: 0/255, alpha: 1)
        return message
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return savedRecipes.isEmpty ? 200 : 0
    }
}

// MARK: - Extension for searchBar implementation
extension FavoriteRecipesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            savedRecipes = RecipeEntity.fetchAll()
        } else {
            savedRecipes = RecipeEntity.fetch(name: searchText)
        }
        savedResultsTableView.reloadData()
    }
}
