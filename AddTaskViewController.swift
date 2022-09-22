//
//  AddTaskViewController.swift
//  StoryApplication
//
//  Created by Eduard Spahija on 9/21/22.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var subject: UITextField!
    @IBOutlet var story_description: UITextField!
    @IBOutlet var email : UITextField!
    @IBOutlet var doneBarButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTask () {
        
        let story = StoryEntity(context: contex)
        story.subject = subject.text!
        story.story_description = story_description.text!
        getPersonByEmail(email: email.text!).addToStories(story)
        do {
            try contex.save()
            let vc = storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
            vc.title = "Stories Assigned"
            navigationController?.pushViewController(vc, animated: true)
        }catch {
            print("Something happened")
        }
        
    }
    
    func getPersonByEmail (email: String) -> EmployeeEntity {
        var result = NSArray()
        var empEntity :EmployeeEntity
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        
        let predicate = NSPredicate(format: "email = %@", email)
        
        fetchReq.predicate = predicate
        
        do {
            result = try contex.fetch(fetchReq) as NSArray
            print("hini n do add task")
            print("Res count n add task" + String(result.count))
            if (result.count > 0) {
                empEntity = result.firstObject as! EmployeeEntity
                return empEntity
                
            }else {
                showAlert(message: "Credentials are wrong")
            }
        }
        catch {
            showAlert(message: "Something went wrong")
        }
        
        return NSManagedObject.self as! EmployeeEntity
    }
    
    func showAlert (message: String) {
            
            print("show aler ne add task")
            // create the alert
            let alert = UIAlertController(title: "Error message", message: message, preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    func helloWorld () {
        print("helloooo")
    }

}
