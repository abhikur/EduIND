import UIKit
import CoreData
import Alamofire
import FBSDKLoginKit

class SaveStudentVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var studentsImage: UIImageView!
    @IBOutlet weak var desc: UITextView!
    
    
    let appDel = (UIApplication.sharedApplication().delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageSelectionGesture = UITapGestureRecognizer(target: self, action: #selector(SaveStudentVC.selectImage))
        studentsImage?.userInteractionEnabled = true
        studentsImage?.addGestureRecognizer(imageSelectionGesture)
    }
    
    @IBAction func saveStudent(sender: UIButton) {
        let context = appDel!.managedObjectContext
        let userDescription = NSEntityDescription.entityForName("Student", inManagedObjectContext: context)
        
        let student = Student(entity: userDescription!, insertIntoManagedObjectContext: context)
        
        student.name = name.text
        student.age = age.text
        student.city = city.text
        student.state = state.text
        student.country = country.text
        student.desc = desc.text
        let image:UIImage = studentsImage.image!
        let imageData = UIImagePNGRepresentation(image)
        student.image = imageData
        saveContext(context);
    }
    
    func saveContext(context: NSManagedObjectContext) {
        do{
            try context.save()
        }catch {
            let errPopup = UIAlertController(title: "error", message: "Student didn't saved", preferredStyle: .Alert)
            let okAct = UIAlertAction(title: "ok", style: .Default) {(UIAlertAction) in
                
            }
            errPopup.addAction(okAct)
            self.presentViewController(errPopup, animated: true, completion: nil)
        }
        
        let popup = UIAlertController(title: "saved", message: "Student saved", preferredStyle: .Alert)
        let okAct = UIAlertAction(title: "ok", style: .Default) {(UIAlertAction) in
            self.appDel?.switchTo("Root")
        }
        popup.addAction(okAct)
        self.presentViewController(popup, animated: true, completion: nil)
        
        
    }
    
    func postRequest() {
        Alamofire.request(.GET, "http://localhost:3000", parameters: nil, encoding: ParameterEncoding.URL, headers: nil)
            .response { (req, res, data, error) in
                print(data!, req, res, error)
            }
            .responseJSON { (res) in
                print(res)
        }
    }
    
    func selectImage() {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .PhotoLibrary
        imgPicker.delegate = self
        presentViewController(imgPicker, animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let choosedImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        studentsImage.image = choosedImg
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutButton(sender: UIButton) {
        let manager = FBSDKLoginManager()
        manager.logOut()
        appDel?.switchTo("Root")
    }
    
    func postRequest() {
        Alamofire.request(.GET, "http://localhost:3000", parameters: nil, encoding: ParameterEncoding.URL, headers: nil)
            .responseJSON { (res) in
                let response = res.result.value as! NSDictionary
                print("aa gya= ", response.objectForKey("Name"))
                print("Another res= ", res)
        }
        
        let parameters: [String: String] = [
            "Name": name.text!,
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/saveUser", parameters: parameters, encoding: ParameterEncoding.JSON, headers: ["Content-Type":"application/json"])
            .responseJSON { (res) in
                print(res)
        }
    }
}

