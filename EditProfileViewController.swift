//
//  EditProfileViewController.swift
//  StoryApplication
//
//  Created by Eduard Spahija on 9/22/22.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var positionField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Email te edit profile ?????" + ConfigClass.email)
        initUi()
    }
    
    func initUi () {
        let empEntity = getEmployeeData(email: ConfigClass.email)
        
        print("Empentity name " + empEntity.name!)
        print("Namefield name beforee " + nameField.text!)
        nameField.text! = empEntity.name!
        print("Namefield name after " + nameField.text!)
        lastNameField.text! = empEntity.last_name!
        emailField.text! = empEntity.email!
        positionField.text! = empEntity.position!
    }
    
    func returnContext () -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func getEmployeeData (email: String) -> EmployeeEntity {
        var obj :EmployeeEntity
        do {
            let items = try returnContext().fetch(EmployeeEntity.fetchRequest())
            
            print("Stringgg " + String(items.count))
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
            print("Exception")
        }
    }
    
    func showAlert (message: String, actionTitle: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
