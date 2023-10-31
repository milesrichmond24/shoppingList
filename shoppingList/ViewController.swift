//
//  ViewController.swift
//  shoppingList
//
//  Created by MILES RICHMOND on 10/31/23.
//

import UIKit

class ViewController: UIViewController {
    var list: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func add_action(_ sender: UIButton) {
        let alertContr = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default)
        
        alertContr.addAction(add)
        alertContr.addAction(cancel)
    }
    
    @IBAction func delete_actionq(_ sender: UIButton) {
        
    }
}

