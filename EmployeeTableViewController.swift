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
        tableView.rowHeight = 115
        getAllEmployees()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let empItem = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomEmployeeTableViewCell
        let fullName = empItem.name! + " " + empItem.last_name!
        cell.fullName.text = fullName
        cell.email.text = empItem.email!
        cell.position.text = empItem.position!
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
