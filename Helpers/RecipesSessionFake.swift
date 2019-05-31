//
//  RecipesSessionFake.swift
//  Reciplease
//
//  Created by Michael Favre on 12/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation
import Alamofire
//@testable import AlamofireTest
//
//class RecipesSessionFake: RecipesProtocol {
//    
//    private let fakeResponse: FakeResponse
//    
//    init(fakeResponse: FakeResponse) {
//        self.fakeResponse = fakeResponse
//    }
//    
//    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
//        let httpResponse = fakeResponse.response
//        let data = fakeResponse.data
//        let error = fakeResponse.error
//        
//        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
//        let urlRequest = URLRequest(url: URL(string: urlStringApi)!)
//        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
//    }
//}
