//
//  RecipesProtocol.swift
//  Reciplease
//
//  Created by Michael Favre on 11/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipesProtocol {
//    var baseRecipesUrlString: String { get set }
//    var baseRecipeUrlString: String { get set }
//    var ingredients: [String] { get set }
//    var id: String { get set }
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
