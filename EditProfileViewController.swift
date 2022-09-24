import UIKit
import CoreData

class EditProfileViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var positionField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUi()
    }
    
    func initUi () {
        let empEntity = getEmployeeData(email: ConfigClass.email)
        nameField.text! = empEntity.name!
        lastNameField.text! = empEntity.last_name!
        emailField.text! = empEntity.email!
        positionField.text! = empEntity.position!
    }
    
    func returnContext () -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func getEmployeeData (email: String) -> EmployeeEntity {
        do {
            let items = try returnContext().fetch(EmployeeEntity.fetchRequest())
            for x in items {
                print(x)
                if (x.email!.elementsEqual(email)) {
                    return x
                }
            }
        }
        catch {
        }
        return NSManagedObject.self as! EmployeeEntity
    }
    
    @IBAction func editData () {
        let empEntity : EmployeeEntity = getEmployeeData(email: ConfigClass.email)
        
        empEntity.name = nameField.text!
        empEntity.last_name = lastNameField.text!
        empEntity.email = emailField.text!
        empEntity.position = positionField.text!
        
        do {
            try returnContext().save()
            showAlert(message: "Success Data Changed", actionTitle: "OK")
        }catch {
            showAlert(message: "Something went wrong", actionTitle: "Try again")
        }
    }
    
    func showAlert (message: String, actionTitle: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
