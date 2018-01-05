//
//  CategoryViewControllerTableViewController.swift
//  ToDo
//
//  Created by Nhu Luong on 1/5/18.
//  Copyright © 2018 Nhu Luong. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categoryArray = [Category]()

     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    //MARK : - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }

    //MARK : - Data Manipulation Methods
    
    //MARK : - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.categoryArray.append(newItem)
            //Don't use UserDefaults for complex case. Mostly simple cases like volume up down should be good
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            //Store the reference to the alertTextField
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    //MARK : TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TodoListViewController
        //Get the index path of selected row
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    func saveItems(){
        do {
            //All the changes will be made here
            try context.save()
        }
        catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }
}
