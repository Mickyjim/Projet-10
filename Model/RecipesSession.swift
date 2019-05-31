//
//  RecipesSession.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import Alamofire

class RecipesSession: RecipesProtocol {
    var baseRecipesUrlString: String = "http://api.yummly.com/v1/api/recipes?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9"
    
    var ingredients: [String] = [] {
        didSet {
            
            baseRecipesUrlString = "http://api.yummly.com/v1/api/recipes?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9"
            var parameters = ""
            for ingredient in ingredients {
                parameters += "&allowedIngredient%5B%5D=\(ingredient)"
            }
            baseRecipesUrlString += parameters
        }
    }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }
}
