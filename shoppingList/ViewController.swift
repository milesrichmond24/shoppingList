//
//  ViewController.swift
//  shoppingList
//
//  Created by MILES RICHMOND on 10/31/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Item] = []
    var selectedIndex: Int = -1

    //
    //
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let data = defaults.data(forKey: "list") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Item].self, from: data) {
                list = decoded
            }
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(list) {
            defaults.setValue(encoded, forKey: "list")
        }
    }
    
    func isDuplicate(_ item: Item) -> Bool {
        for i in list {
            if(i.name == item.name) {
                return true
            }
        }
        
        return false
    }
    
    //
    //
    //

    @IBAction func add_action(_ sender: UIButton) {
        var item: Item = Item(section: FoodType.none, name: "Unnamed", color: "Unnamed", checked: false)
        
        let alertContr = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        
        alertContr.addTextField()

        alertContr.addTextField()
        alertContr.textFields![0].placeholder = "Name"
        alertContr.textFields![1].placeholder = "Color"
        
        let add = UIAlertAction(title: "Add", style: .default) { action in
            item.name = alertContr.textFields![0].text ?? ""
            item.color = alertContr.textFields![1].text ?? ""
            
            if(self.isDuplicate(item)) {
                let duplicateAlertContr = UIAlertController(title: "Error", message: "Duplicate Item", preferredStyle: .alert)
                duplicateAlertContr.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(duplicateAlertContr, animated: true)
                return
            }
            
            self.list.append(item)
            
            self.tableView.reloadData()
            self.saveData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertContr.addAction(add)
        alertContr.addAction(cancel)
        
        present(alertContr, animated: true)
        
    }
    
    @IBAction func delete_actionq(_ sender: UIButton) {
        if(selectedIndex == -1 || selectedIndex > list.count) {
            return
        }
        
        list.remove(at: selectedIndex)
        selectedIndex = -1
        tableView.reloadData()
        saveData()
    }
    
    @IBAction func sort_action(_ sender: UIButton) {
        list.sort(by: {$0.name > $1.name})
        tableView.reloadData()
    }
    
    @IBAction func check_action(_ sender: UIButton) {
        if(selectedIndex == -1 || selectedIndex > list.count) {
            return
        }
        
        list[selectedIndex].checked = !list[selectedIndex].checked
        tableView.reloadData()
        selectedIndex = -1
        saveData()
    }
    
    @IBAction func edit_action(_ sender: UIButton) {
        let alertContr = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertContr.addAction(cancel)
        
        if(selectedIndex == -1 || selectedIndex > list.count) {
            alertContr.title = "Error"
            alertContr.message = "No item selected"
            
            present(alertContr, animated: true)
            return
        }
        
        alertContr.addTextField()
        alertContr.addTextField()
        alertContr.textFields![0].placeholder = "Name (Leave empty if no changes)"
        alertContr.textFields![1].placeholder = "Color (Leave empty if no changes"
        
    
        
        let save = UIAlertAction(title: "Save", style: .default) { action in
            if(alertContr.textFields![0].text != "" && alertContr.textFields![1].text != "") {
                self.list[self.selectedIndex].color = alertContr.textFields![1].text!
                self.list[self.selectedIndex].name = alertContr.textFields![0].text!
            } else if(alertContr.textFields![0].text != "") {
                self.list[self.selectedIndex].name = alertContr.textFields![0].text!
            } else if(alertContr.textFields![1].text != "") {
                self.list[self.selectedIndex].color = alertContr.textFields![1].text!
            }
            
            self.tableView.reloadData()
            self.saveData()
        }
        
        alertContr.addAction(save)
        
        present(alertContr, animated: true)
        
    }
    
    //
    //
    //
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item") as! ItemCell
        let item = list[indexPath.row]
        
        print("Index: \(indexPath.row)")
        
        cell.name_label.text = item.name
        cell.color_label.text = item.color
        
        if(item.checked) {
            cell.color_label.textColor = UIColor.secondaryLabel
            cell.name_label.textColor = UIColor.secondaryLabel
        } else {
            cell.color_label.textColor = UIColor.black
            cell.name_label.textColor = UIColor.black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        selectedIndex = indexPath.row
        delete_actionq(nil)
    }
}

