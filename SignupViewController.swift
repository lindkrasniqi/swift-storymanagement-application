import UIKit
import CoreData

class SignupViewController: UIViewController {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var nameField : UITextField!
    @IBOutlet var lastNameField : UITextField!
    @IBOutlet var emailField : UITextField!
    @IBOutlet var positionField : UITextField!
    @IBOutlet var passwordField : UITextField!
    @IBOutlet var confirmPasswordField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpUser () {
        let name : String = nameField.text!
        let lastName : String = lastNameField.text!
        let email : String = emailField.text!
        let password : String = passwordField.text!
        let confirmPassword : String = confirmPasswordField.text!
        let position : String = positionField.text!
        
        if (password.elementsEqual(confirmPassword)) {
            let newEmp  = EmployeeEntity(context: contex)
            newEmp.email = email
            newEmp.name = name
            newEmp.last_name = lastName
            newEmp.position = position
            newEmp.password = password
            
            do {
                try contex.save()
                let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
                vc.title = "Stories assigned"
                navigationController?.pushViewController(vc, animated: true)
            }
            catch {
                print("Error")
            }
        }
        else {
            showAlert()
        }
        
        
    }
    
    func showAlert() {
            let alert = UIAlertController(title: "Error message", message: "Passwords do not match .", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
