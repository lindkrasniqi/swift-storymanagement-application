import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet var tableView: UITableView!
    @IBOutlet var Ssubject: UITextField!
    @IBOutlet var Sstory_description: UITextField!
    @IBOutlet var email : UITextField!
    
    func returnContext () -> NSManagedObjectContext {
        
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var text: String = ""
    var model = [StoryEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(text)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.frame = view.bounds
        tableView.rowHeight = 115
        getStoriesAssigned(email: ConfigClass.email)
        // Do any additional setup after loading the view.
    }
    
    lazy var storyItem = StoryEntity(context: returnContext())

    func getStoriesAssigned (email: String) {
        
        var result = [StoryEntity]()
        do {
        let items = try returnContext().fetch(StoryEntity.fetchRequest())
            print(items.count)
            for r in items {
                if (r.assignee?.email != nil) {
                    if (r.assignee!.email!.elementsEqual(email)) {
                        result.append(r)
                    }
                }
            }
        }
        catch {
                
        }
        model = result
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let result = dateFormatter.string(from: model[indexPath.row].dateTime!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.subject.text! = model[indexPath.row].subject!
        cell.story_description.text! = model[indexPath.row].story_description!
        cell.dateTime.text! = result
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        storyItem = model[indexPath.row]
        let sheet = UIAlertController(title: "edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default,
            handler: { _ in
            
            self.changeView()
            
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive,
            handler: { _ in
            self.deleteItem(storyItem: self.storyItem)
        }))
        
        self.present(sheet, animated: true)
    }

    func changeView() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "editTask") as! EditTaskViewController
        vc.title = "Edit task"
        vc.storyItem = storyItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteItem (storyItem: StoryEntity) {
        returnContext().delete(storyItem)
        try! returnContext().save()
        getStoriesAssigned(email: ConfigClass.email)
    }
    
    @IBAction func addStoryButton () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addTask") as! AddTaskViewController
        vc.title = "Edit task"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showEmployeesButton () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "employeeTable") as! EmployeeTableViewController
        vc.title = "Employees"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editProfileButton () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "editEmployee") as! EditProfileViewController
        vc.title = "Employees"
        navigationController?.pushViewController(vc, animated: true)
    }
}
