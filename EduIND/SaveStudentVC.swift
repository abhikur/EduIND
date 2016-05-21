import UIKit
import CoreData
import Alamofire
import FBSDKLoginKit

class SaveStudentVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    let appDel = (UIApplication.sharedApplication().delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageSelectionGesture = UITapGestureRecognizer(target: self, action: #selector(SaveStudentVC.selectImage))
        imageView?.userInteractionEnabled = true
        imageView?.addGestureRecognizer(imageSelectionGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveStudent(sender: UIButton) {
        let context = appDel!.managedObjectContext
        let userDescription = NSEntityDescription.entityForName("Student", inManagedObjectContext: context)
        
        let student = Student(entity: userDescription!, insertIntoManagedObjectContext: context)
        let image:UIImage = imageView.image!
        let imageData = UIImagePNGRepresentation(image)
        student.firstName = firstName.text
        student.lastName = lastName.text
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
        imageView.image = choosedImg
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutButton(sender: UIButton) {
        let manager = FBSDKLoginManager()
        manager.logOut()
        appDel?.switchTo("Root")
    }
}

