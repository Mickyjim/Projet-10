//
//  String.swift
//  Reciplease
//
//  Created by Michael Favre on 31/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation

// Converting Int to String
extension String {
    var data: Data? {
        if let url = URL(string: self) {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }
    
    var imageResolutionIncrease: String {
        return self.dropLast(2) + "320"
    }
}
