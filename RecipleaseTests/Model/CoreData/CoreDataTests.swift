//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Michael Favre on 09/07/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    
    //MARK: - Properties
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    //MARK: - Helper Methods
    private func savedRecipe(into managedObjectContext: NSManagedObjectContext) {
        let savedRecipe = RecipeEntity(context: managedObjectContext)
        savedRecipe.id = "Best-Easy-Honey-Lemon-Chicken-2721136"
        savedRecipe.name = "Best Easy Honey Lemon Chicken"
        savedRecipe.totalTime = "2700"
        savedRecipe.rating = "4"
        //        savedRecipe.imageData = "https://lh3.googleusercontent.com/QLVn6pH36VfGGX2Bi1w4gImlhrN_TKDptQpxi3J_eWy8rXKlu-eLltfE6wnpNAeMQD2yM-p6S7JgAdHSA7Zk=s90"
        savedRecipe.sourceUrl = "http://api.yummly.com/v1/api/recipes?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9"
        
    }
    
    private func savedIngredients(into managedObjectContext: NSManagedObjectContext, for RecipeEntity: RecipeEntity) {
        let ingredients =  ["Lemon", "Orange", "Apple"]
        for ingredient in ingredients {
            let ingredientEntity = IngredientEntity(context: managedObjectContext)
            ingredientEntity.name = ingredient
            ingredientEntity.recipe = RecipeEntity
        }
    }
    
    private func savedIngredientLines(into managedObjectContext: NSManagedObjectContext, for RecipeEntity: RecipeEntity) {
        let ingredientLines =  ["1 Lemon", "1 Orange", "1 Apple"]
        for ingredientLine in ingredientLines {
            let ingredientLineEntity = IngredientLineEntity(context: managedObjectContext)
            ingredientLineEntity.name = ingredientLine
            ingredientLineEntity.recipe = RecipeEntity
        }
    }
    
    //MARK: - Unit Tests
    func testSavedRecipe_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.newBackgroundContext())
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testDeleteAllRecipeIngredients_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testDeleteSavedRecipe_WhenCorrectDtaIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.viewContext)
        RecipeEntity.delete(id: "Best-Easy-Honey-Lemon-Chicken-2721136", viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).count, 0)
    }
    
    func testIsRegisteredRecipe_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(RecipeEntity.isRegistered(id: "Best-Easy-Honey-Lemon-Chicken-2721136", viewContext: mockContainer.viewContext))
    }
    
    func testfetchSavedRecipeById_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(RecipeEntity.fetch(id: "Best-Easy-Honey-Lemon-Chicken-2721136", viewContext: mockContainer.viewContext).first?.id, "Best-Easy-Honey-Lemon-Chicken-2721136")
    }
    
    func testfetchSavedRecipeByName_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        savedRecipe(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertEqual(RecipeEntity.fetch(name: "Best Easy Honey Lemon Chicken", viewContext: mockContainer.viewContext).first?.name, "Best Easy Honey Lemon Chicken")
    }
    
    func testAddRecipeEntity_WhenCorrectDataIsPassed_ShouldReturnCorrectDataInPersistentContainer() {
        let recipeDetails = RecipeDetails(id: "Best-Easy-Honey-Lemon-Chicken-2721136", name: "Best Easy Honey Lemon Chicken", ingredientLines: ["Honey"], source: Source(sourceRecipeUrl: "https://www.google.com"), totalTimeInSeconds: 2700, rating: 4, images: [RecipeImage(hostedLargeUrl: "https://lh3.googleusercontent.com/8H_kR4fF6IE517FKDHGOyVHEgNmmCdhX_Yz2YfxIDJgCQoU_NJ-hw_FJ1jEolQPPAfoKuKMw4jYjJK512gTyfQ=s90-c")])
        RecipeEntity.add(recipeDetails: recipeDetails, ingredients: ["Honey"], viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(!RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).isEmpty)
    }
}
