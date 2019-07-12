//
//  IngredientEntity.swift
//  Reciplease
//
//  Created by Michael Favre on 24/06/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import CoreData

class IngredientEntity : NSManagedObject {
    static func add(recipe: RecipeEntity, ingredients: [String], viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        for ingredient in ingredients {
            let ingredientEntity = IngredientEntity(context: viewContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recipe = recipe
        }
    }
}
