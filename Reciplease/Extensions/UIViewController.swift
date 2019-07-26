//
//  UIViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 24/07/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

/// Alert message implementation
extension UIViewController {
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
