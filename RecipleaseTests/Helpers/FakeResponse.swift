//
//  FakeResponse.swift
//  Reciplease
//
//  Created by Michael Favre on 28/06/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}
