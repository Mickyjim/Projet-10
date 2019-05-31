//
//  RecipeResultDisplayViewController.swift
//  Reciplease
//
//  Created by Michael Favre on 18/05/2019.
//  Copyright © 2019 Michael Favre. All rights reserved.
//

import UIKit

class RecipeResultDisplayViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    
    let customCellId = "CustomTableViewCell"
    let cells = [CustomCell]()
    var recipes = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.register(UINib.init(data: customCellId, bundle: nil), forCellReuseIdentifier: customCellId)
        resultTableView.rowHeight = UITableView
        
    }
    
//    extension RecipeResultDisplayViewController: UITableViewDataSource {
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return ingredientList.coun
//        }
//        
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientInputCell", for: indexPath)
//            cell.textLabel?.text = ingredientList[indexPath.row]
//            
//            return cell
//        }
//    }
    
    
}
