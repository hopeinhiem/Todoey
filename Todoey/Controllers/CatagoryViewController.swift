//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Andrew Greene on 2018-10-20.
//  Copyright © 2018 Andrew Greene. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CatagoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var catagoryArray: Results<Catagory>?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    loadCatagory()
        tableView.rowHeight = 80
        
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = catagoryArray?[indexPath.row].name ?? "No Catagories Added Yet!"
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagoryArray?[indexPath.row]
        }
    }
    
    
    
    //Mark: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catagory", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            
            let newCatagory = Catagory()
            newCatagory.name = textField.text!
            
            self.saveCatagory(catagory: newCatagory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new catagory"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Data Manipulation Methods
    func saveCatagory(catagory: Catagory) {
        do {
            try realm.write {
                realm.add(catagory)
            }
        } catch {
            print("error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCatagory() {

        catagoryArray = realm.objects(Catagory.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let catagoryForDeletion = self.catagoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(catagoryForDeletion)
                    print("delete cell")
                }
            } catch {
                print("error saving context \(error)")
            }
        }
    }
    
    
}



