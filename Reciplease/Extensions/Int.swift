//
//  Int.swift
//  Reciplease
//
//  Created by Michael Favre on 31/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import Foundation

// Converting String to Int
extension Int {
    var timeInSecondsToString: String {
        let minutes = self % (60*60) / 60
        let hours = self / 60 / 60
        let time = String(format: "%01dh%02dm", hours, minutes)
        return time
    }
}
