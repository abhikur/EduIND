import UIKit
import FBSDKLoginKit

class LoginFB: UIViewController, FBSDKLoginButtonDelegate {
    
    let appDel = UIApplication.sharedApplication().delegate as? AppDelegate
    
    @IBOutlet weak var loginBtn: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.readPermissions = ["public_profile","email","user_friends"]
        loginBtn.center = self.view.center
        loginBtn.delegate = self
        self.view.addSubview(loginBtn)
    }
    
    override func viewWillAppear(animated: Bool) {
        let access:FBSDKAccessToken! = FBSDKAccessToken.currentAccessToken()
        if((access) != nil) {
            appDel?.switchTo("addPage")
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil{
            print("Login complete.")
            appDel?.switchTo("addPage")
        }
        else{
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Logging out...")
    }
    
    
}

