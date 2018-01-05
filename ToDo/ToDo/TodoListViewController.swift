//
//  ViewController.swift
//  ToDo
//
//  Created by Nhu Luong on 1/4/18.
//  Copyright © 2018 Nhu Luong. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Grocery", "SWE", "AWS Study"]
    
    //Store persisted database - each app has its own sandbox
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else { tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //Store the reference to the alertTextField
            textField = alertTextField
            
        }
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            print("Sucess!")
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }

      
        alert.addAction(action)
        
       
        present(alert,animated: true,completion: nil)
    }
    
}

