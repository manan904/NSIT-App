//
//  SignInViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 23/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var rollNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()

        
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
    }
    
    
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.rollNo.text!, password: self.password.text!) { (user, error) in
            
            if error == nil {
                
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                
                //Go to the HomeViewController if the login is sucessful
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
                self.present(vc!, animated: true, completion: nil)
                
            } else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
    }

}
