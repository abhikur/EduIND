import UIKit
import CoreData
import Alamofire
import FBSDKLoginKit

class SaveStudentVC: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    let appDel = (UIApplication.sharedApplication().delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveStudent(sender: UIButton) {
        let context = appDel!.managedObjectContext
        let userDescription = NSEntityDescription.entityForName("Student", inManagedObjectContext: context)
        
        let student = Student(entity: userDescription!, insertIntoManagedObjectContext: context)
        
        student.firstName = firstName.text
        student.lastName = lastName.text
        saveContext(context);
    }
    
    func saveContext(context: NSManagedObjectContext) {
        do{
            try context.save()
        }catch {
            let errorPopUp = UIAlertView(title: "Error", message: "Cannot save", delegate: nil, cancelButtonTitle: "Ok")
            errorPopUp.show()
        }
        let successAlert = UIAlertController(title: "Success", message: "successfully added", preferredStyle: .Alert)
        let okAct = UIAlertAction(title: "Ok", style: .Default){
            UIAlertAction in
            self.appDel!.switchTo("Root")
            let loginManager = FBSDKLoginManager()
            loginManager.logOut();
            
        }
        successAlert.addAction(okAct)
        self.presentViewController(successAlert, animated: true, completion: nil)
    }
    
}

