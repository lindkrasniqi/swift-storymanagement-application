import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var emailField : UITextField!
    @IBOutlet var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInUser () {
        checkIfUsernameAndPasswordMatch(userName: emailField.text!, password: passwordField.text!)
            self.emailField.text = ""
            self.passwordField.text = ""
    }
    
    @IBAction func createAccount () {
     
        let vc = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignupViewController
        vc.title = "Sign Up"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showAlert () {
            let alert = UIAlertController(title: "Error message", message: "Credentials are wrong.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    func checkIfUsernameAndPasswordMatch (userName: String, password: String) {
        var result = NSArray()
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        
        let predicate = NSPredicate(format: "email = %@", userName)
        
        fetchReq.predicate = predicate
        
        do {
            result = try contex.fetch(fetchReq) as NSArray
            if (result.count > 0) {
                let empEntity = result.firstObject as! EmployeeEntity
                if (empEntity.email!.elementsEqual(userName) &&
                    empEntity.password!.elementsEqual(password)) {
                    print("Login successfully")
                    ConfigClass.email = userName
                    let vc = storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
                    vc.title = "Stories assigned"
                    vc.text = userName
                    navigationController?.pushViewController(vc, animated: true)
                }else {
                    showAlert()
                }
            }else {
                showAlert()
            }
        }
        catch {
            showAlert()
        }
    }


}

