//
//  IngredientLineEntity.swift
//  Reciplease
//
//  Created by Michael Favre on 24/06/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import CoreData

class IngredientLineEntity : NSManagedObject {
    static func add(recipe: RecipeEntity, ingredientsLine: [String], viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        for ingredientLine in ingredientsLine {
            let ingredientLineEntity = IngredientLineEntity(context: viewContext)
            ingredientLineEntity.name = ingredientLine
            ingredientLineEntity.recipe = recipe
        }
    }
}
