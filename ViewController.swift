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
        //if (email.elementsEqual("admin") && password.elementsEqual("admin")) {
        checkIfUsernameAndPasswordMatch(userName: emailField.text!, password: passwordField.text!)
            self.emailField.text = ""
            self.passwordField.text = ""
    }
    
    @IBAction func createAccount () {
     
        let vc = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignupViewController
        vc.title = "Sign Up"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func getAllUsers () {
        do {
        let items = try contex.fetch(EmployeeEntity.fetchRequest())
            print(items.count)
            for r in items {
                //print("dhe pass " + r.password!)
                //guard let values = r.stories else { return }
                //for i in values {
                  //  print(i)
                print(r.email)
            }
            }
        catch {}
    }
    
    func getAllStories () {
        do {
        let items = try contex.fetch(StoryEntity.fetchRequest())
            print(items.count)
            for r in items {
                print(r.assignee?.email)
            }
            }
        catch {}
    }
    
    func getStoriesAssigned (email: String) -> Array<StoryEntity> {
        
        var result : Array<StoryEntity> = [StoryEntity]()
        
        do {
        let items = try contex.fetch(StoryEntity.fetchRequest())
            print(items.count)
            for r in items {
                if (r.assignee?.email != nil) {
                    if (r.assignee!.email!.elementsEqual(email)) {
                        result.append(r)
                    }
                }
            }
        }
            catch {}
        
        return result
    }
    
    func showAlert () {

            // create the alert
            let alert = UIAlertController(title: "Error message", message: "Credentials are wrong.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    func checkIfUsernameAndPasswordMatch (userName: String, password: String) {
        var result = NSArray()
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        
        let predicate = NSPredicate(format: "email = %@", userName)
        
        fetchReq.predicate = predicate
        
        do {
            result = try contex.fetch(fetchReq) as NSArray
            print("hini n do")
            print("Res count " + String(result.count))
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

