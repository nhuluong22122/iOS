//
//  CategoryViewControllerTableViewController.swift
//  ToDo
//
//  Created by Nhu Luong on 1/5/18.
//  Copyright © 2018 Nhu Luong. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {

    
    var categoryArray : Results<Category>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        tableView.rowHeight = 80.0
    }

    //MARK : - Data Manipulation Methods
    
    //MARK : - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let c = Category()
            c.name = textField.text!
//            self.categoryArray?.append(c)
            //Don't use UserDefaults for complex case. Mostly simple cases like volume up down should be good
            self.save(category: c)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            //Store the reference to the alertTextField
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    //MARK : - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Inheret method from superclass
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
            return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if it's not null return count -> if null -> return 1
        return categoryArray?.count ?? 1
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TodoListViewController
        //Get the index path of selected row
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    func save(category: Category){
        do {
            //All the changes will be made here
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    func load(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
        do {
            try self.realm.write {
                self.realm.delete(categoryForDeletion)
            }
        } catch {
            print("Error deleting category, \(error)")
        }
        
    } }
}

