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


class SignUpViewController: UIViewController{
    
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var rollNo: UITextField!
    @IBOutlet weak var branch: UITextField!
    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!

    var pickerData: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let firstName = self.firstName.text
        let email = self.emailID.text
        let rollNo = self.rollNo.text
        let branch = self.branch.text
        let section = self.section.text
        
        Auth.auth().createUser(withEmail: emailID.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                print("You have successfully signed up")
                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                
                guard let uid = user?.uid else {
                    return
                }
                
                let userReference = self.databaseRef.child("Users").child(uid)
                
                let values = ["Name": firstName , "Email": email , "RollNo": rollNo , "Branch": branch , "Section": section]
                
                self.pickerData = ["COE", "IT", "ECE", "ICE", "MPAE", "ME","BT"]
                
                
                userReference.updateChildValues(values as Any as! [AnyHashable : Any], withCompletionBlock: { (error, ref) in
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

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
}
