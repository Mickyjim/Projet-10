//
//  Recipes.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import Alamofire

struct Recipes: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let ingredients: [String]
    let id: String
    let smallImageUrls: [String]?
    let recipeName: String
    let totalTimeInSeconds: Int
    let rating: Int
}
