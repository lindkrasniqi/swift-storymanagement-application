//
//  EmployeeTableViewController.swift
//  StoryApplication
//
//  Created by Eduard Spahija on 9/22/22.
//

import UIKit
import CoreData

class EmployeeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    func returnContext () -> NSManagedObjectContext {
        
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var model = [EmployeeEntity]()
    
    lazy var empItem = EmployeeEntity(context: returnContext())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        getAllEmployees()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = model[indexPath.row].email
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        empItem = model[indexPath.row]
        
        let sheet = UIAlertController(title: "Delete Employee", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive,
            handler: { _ in
            self.deleteItem(empItem: self.empItem)
        }))
        
        self.present(sheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Length " + String(model.count))
        return model.count
        
    }
    
    func deleteItem (empItem: EmployeeEntity) {
        do {
            returnContext().delete(empItem)
            try returnContext().save()
            getAllEmployees()
        }
        catch {
            print("Something went wrong")
        }
    }
    
    func getAllEmployees ()  {
        do {
            let items = try returnContext().fetch(EmployeeEntity.fetchRequest())
            model = items
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
        catch {
            print("Something wrong happened")
        }
    }
}
