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
            print(access)
            appDel?.switchTo("addPage")
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let loginManager = FBSDKLoginManager()
        let permissions = ["public_profile"]
        loginManager.logInWithReadPermissions(permissions, fromViewController: self) { (result, error) in
            print(result.isCancelled)
            if((error) != nil) {
                print(error.localizedDescription)
            }
            else if(result.isCancelled == true) {
                print("Cancelled")
                self.appDel?.switchTo("Root")
            }
            else{
                print("Login complete.")
                print("Profile == ", FBSDKProfile.currentProfile())
                self.appDel?.switchTo("addPage")
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Logging out...")
    }
    
    
}

