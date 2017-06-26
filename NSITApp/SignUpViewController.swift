//
//  SignUpViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 23/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var rollNo: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let firstName = self.firstName.text
        let email = self.rollNo.text
        
        Auth.auth().createUser(withEmail: rollNo.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                print("You have successfully signed up")
                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                
                guard let uid = user?.uid else {
                    return
                }
                
                let userReference = self.databaseRef.child("Users").child(uid)
                
                let values = ["Name": firstName , "email": email]
                
                
                userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print (error!)
                        return
                    }
                })
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
                self.present(vc!, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        
    }
}

}
