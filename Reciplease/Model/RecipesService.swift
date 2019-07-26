//
//  RecipesService.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import Alamofire

class RecipesService {
    
    // MARK: - Property
    private var recipeSession: RecipesSession
    
    init(recipeSession: RecipesSession = RecipesSession()) {
        self.recipeSession = recipeSession
    }

    // MARK: - Method recipes
    /// API request procedure for recipes data
    func getRecipes(ingredients: [String], completionHandler: @escaping (Bool, [Match]?) -> Void) {
        recipeSession.ingredients = ingredients
        guard let url = URL(string: recipeSession.baseRecipesUrlString) else { return }
        recipeSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipes.matches)
        }
    }
    // MARK: - Method recipeDetails
    /// API request procedure for details in recipes data
    func getDetailedRecipes(id: String, completionHandler: @escaping (Bool, RecipeDetails?) -> Void) {
        recipeSession.id = id
        guard let url = URL(string: recipeSession.baseRecipeUrlString) else { return }
        print(url)
        recipeSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeDetails = try? JSONDecoder().decode(RecipeDetails.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipeDetails)
        }
    }
}
