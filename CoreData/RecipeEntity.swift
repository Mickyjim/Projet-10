//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by Michael Favre on 24/06/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import CoreData

class RecipeEntity : NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let recipeList = try? viewContext.fetch(request) else { return [] }
        return recipeList
    }
    
    static func fetch(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipeEntities = try? viewContext.fetch(request) else { return [] }
        return recipeEntities
    }
    
    static func isRegistered(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipeEntities = try? viewContext.fetch(request) else { return false }
        if recipeEntities.isEmpty { return false }
        return true
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        RecipeEntity.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0)})
        try? viewContext.save()
    }
    
    static func delete(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipeEntities = try? viewContext.fetch(request) else { return }
        guard let recipeEntity = recipeEntities.first else { return }
        viewContext.delete(recipeEntity)
        try? viewContext.save()
    }
    
    static func add(recipeDetails: RecipeDetails, ingredients: [String], viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.name = recipeDetails.name
        recipeEntity.id = recipeDetails.id
        recipeEntity.rating = String(recipeDetails.rating)
        recipeEntity.totalTime = recipeDetails.totalTimeInSeconds.timeInSecondsToString
        recipeEntity.sourceUrl = recipeDetails.source.sourceRecipeUrl
        recipeEntity.imageData = recipeDetails.images[0].hostedLargeUrl?.data
        IngredientEntity.add(recipe: recipeEntity, ingredients: ingredients, viewContext: viewContext)
        IngredientLineEntity.add(recipe: recipeEntity, ingredientsLine: recipeDetails.ingredientLines, viewContext: viewContext)
        try? viewContext.save()
    }
}
