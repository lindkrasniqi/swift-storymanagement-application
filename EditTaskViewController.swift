import UIKit
import CoreData

class EditTaskViewController: UIViewController {
    
    @IBOutlet var subject: UITextField!
    @IBOutlet var story_description: UITextField!
    @IBOutlet var email : UITextField!
    
    
    func returnContext () -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUi()
        // Do any additional setup after loading the view.
    }
    
    func initUi () {
        subject.text! = storyItem.subject!
        story_description.text! = storyItem.story_description!
    }
    
    lazy var storyItem = StoryEntity(context: returnContext())
    
    @IBAction func change () {
        storyItem.subject = subject.text!
        storyItem.story_description = story_description.text!
        do {
            try returnContext().save()
            let vc = storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
            vc.title = "Stories Assigned"
            navigationController?.pushViewController(vc, animated: true)
        }catch {
            
        }
    }
}
