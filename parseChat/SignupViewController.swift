//
//  SignupViewController.swift
//  parseChat
//
//  Created by Daniel Afolabi on 6/26/17.
//  Copyright © 2017 Daniel Afolabi. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    let emailAlertController = UIAlertController(title: "Email Required", message: "Please enter your email.", preferredStyle: .alert)
    let usernameAlertController = UIAlertController(title: "Username Required", message: "Please enter your username.", preferredStyle: .alert)
    let passwordAlertController = UIAlertController(title: "Password Required", message: "Please enter your password.", preferredStyle: .alert)
    let signupErrorAlertController = UIAlertController(title: "Sign up error", message: "There was problem during sign up ", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createAlertControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didHitSignUpButton(_ sender: Any) {
        
        if (emailLabel.text?.isEmpty)!  {
            self.present(emailAlertController, animated: true)
        } else if (usernameLabel.text?.isEmpty)! {
            self.present(usernameAlertController, animated: true)
        } else if (passwordLabel.text?.isEmpty)! {
            self.present(passwordAlertController, animated: true)
        } else {
            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameLabel.text
            //        newUser.email = emailLabel.text
            newUser.password = passwordLabel.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    self.signupErrorAlertController.message = error.localizedDescription
                    self.signupErrorAlertController.title = "Error"
                    self.present(self.signupErrorAlertController, animated: true)
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    self.dismiss(animated: true, completion: nil)
                    // manually segue to logged in view
                }
            }
        }
    }
    
    
    @IBAction func didHitDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createAlertControllers() {
        // add the cancel action to the alertController
        usernameAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.passwordLabel.text = nil
        })
        
        passwordAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.passwordLabel.text = nil
        })
        
        emailAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.passwordLabel.text = nil
            
        })
        
        signupErrorAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.emailLabel.text = nil
            self.usernameLabel.text = nil
            self.passwordLabel.text = nil
            
        })
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
