/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: materialTextfield!
    
    @IBOutlet weak var password: materialTextfield!
    
    @IBOutlet weak var signuplbl: materialButton!
    
    @IBOutlet weak var alreadySignedupLbl: materialButton!
    
    
    var signUpState = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.password.delegate = self

       
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func SigunUpbutton(sender: AnyObject) {
        
        
        
        if username.text == "" || password.text == "" {
            
            alert("Missing Fields", message: "Username and password are required")
            
            
        } else {
            
            if signUpState == true {
                
                let user = PFUser()
                user.username = username.text
                user.password = password.text
           
                user.signUpInBackgroundWithBlock {
                    (succeeded, error) -> Void in
                    if let error = error {
                        if  let errorString = error.userInfo["error"] as? NSString {
                            
                            self.alert("Sign Up Failed", message: String(errorString) + " please try something else.")
                        }
                        
                    } else {
                        
                        
                            
                            self.performSegueWithIdentifier("homepage", sender: self)
                            
                            
                    }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text!, password:password.text!) {
                    (user, error) -> Void in
                    if let user = user {
                        
                        print(user)
                        
                        
                            
                            self.performSegueWithIdentifier("homepage", sender: self)
                            
                         
                        
                    } else {
                        
                        
                        if  let errorString = error!.userInfo["error"] as? NSString {
                            
                            self.alert("Log In Failed", message: String(errorString) + " please try again")
                        }
                        
                        
                    }
                }
                
                
                
                
            }
            
            
        }
        
        
    }
    
    

    
    
    @IBAction func AlreadySignedUpButton(sender: AnyObject) {
        
        
        
        if signUpState == true {
            
            signuplbl.setTitle("Log In", forState: UIControlState.Normal)
            alreadySignedupLbl.setTitle("Not yet member? Sign Up", forState: UIControlState.Normal)
            signUpState = false
            
        } else {
            
            
            signuplbl.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadySignedupLbl.setTitle("Already Signed Up? Log In", forState: UIControlState.Normal)
            signUpState = true
            
                        
            
        }
        
        
        
    }
    
    
    
    
    
    func alert (title :String! , message :String!) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
              self.presentViewController(alert, animated: true, completion: nil)
        } else {
            
            
            print("Alert view not available")
            // Fallback on earlier versions
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
        
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
            
            print(PFUser.currentUser())
            
        self.performSegueWithIdentifier("homepage", sender: self)
                
            
            
        }
        
    }
    
}



