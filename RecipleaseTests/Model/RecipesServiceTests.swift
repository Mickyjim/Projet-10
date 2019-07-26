//
//  RecipesServiceTests.swift
//  RecipleaseTests
//
//  Created by Michael Favre on 01/07/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipesServiceTests: XCTestCase {
    
    /// Testing getRecipes in RecipeService
    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.recipeError)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipesCorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ["lemon"]) { success, recipes in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?[0].id, "Best-Easy-Honey-Lemon-Chicken-2721136")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing getRecipe in RecipeService
    func testGetDetailedRecipes_WhenNoResponseAndNoDataIsPassed_ShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.recipeError)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertFalse(success)
            XCTAssertNil(recipeDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipes_WhenNoDataIsPassed_ShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertFalse(success)
            XCTAssertNil(recipeDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipes_WhenIncorrectResponseIsPassed_ShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertFalse(success)
            XCTAssertNil(recipeDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipes_WhenCorrectAndNilDataIsPassed_ShouldPostFailedCallbackIfResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertFalse(success)
            XCTAssertNil(recipeDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipes_WhenIncorrectDataIsPassed_ShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertFalse(success)
            XCTAssertNil(recipeDetails)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipes_WhenNoErrorAndRecipeDetailsCorrectDataIsPassed_ShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeDetailsCorrectData, error: nil)
        let recipesSessionFake = RecipesSessionFake(fakeResponse: fakeResponse)
        let recipesService = RecipesService(recipeSession: recipesSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getDetailedRecipes(id: "Best-Easy-Honey-Lemon-Chicken-2721136") { success, recipeDetails in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipeDetails)
            XCTAssertEqual(recipeDetails?.id, "Best-Easy-Honey-Lemon-Chicken-2721136")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
