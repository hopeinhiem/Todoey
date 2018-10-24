//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Andrew Greene on 2018-10-20.
//  Copyright © 2018 Andrew Greene. All rights reserved.
//

import UIKit
import CoreData


class CatagoryViewController: UITableViewController {
    
    var catagoryArray = [Catagory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCatagory()
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)

        cell.textLabel?.text = catagoryArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagoryArray[indexPath.row]
        }
    }
    
    
    
    //Mark: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catagory", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            
            let newCatagory = Catagory(context: self.context)
            newCatagory.name = textField.text!
            self.catagoryArray.append(newCatagory)
            
            self.saveCatagory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new catagory"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Data Manipulation Methods
    func saveCatagory() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCatagory(with request: NSFetchRequest<Catagory> = Catagory.fetchRequest()) {
        do {
            catagoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
}
