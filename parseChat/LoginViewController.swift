//
//  LoginViewController.swift
//  parseChat
//
//  Created by Daniel Afolabi on 6/26/17.
//  Copyright © 2017 Daniel Afolabi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    let usernameAlertController = UIAlertController(title: "Username Required", message: "Please enter your username.", preferredStyle: .alert)
    let passwordAlertController = UIAlertController(title: "Password Required", message: "Please enter your password.", preferredStyle: .alert)
    let loginErrorAlertController = UIAlertController(title: "Login error", message: "There was problem during login ", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createAlertControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didHitLoginButton(_ sender: Any) {
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        if username.isEmpty {
            self.present(usernameAlertController, animated: true)
        } else if password.isEmpty {
            self.present(passwordAlertController, animated: true)
        } else {
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    self.present(self.loginErrorAlertController, animated: true)
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
            }
        }
    }
    
    
    func createAlertControllers() {
        // add the cancel action to the alertController
        usernameAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.passwordLabel.text = nil
        })
        
        passwordAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
            self.passwordLabel.text = nil
        })
        
        loginErrorAlertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
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
