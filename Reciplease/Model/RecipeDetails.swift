//
//  RecipeDetails.swift
//  Reciplease
//
//  Created by Michael Favre on 14/06/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation

struct RecipeDetails: Decodable {
    let id: String
    let name: String
    let ingredientLines: [String]
    let source: Source
    let totalTimeInSeconds: Int
    let rating: Int
    let images: [RecipeImage]
}

struct Source: Decodable {
    let sourceRecipeUrl: String
}

struct RecipeImage: Decodable {
    var hostedLargeUrl: String?
}
