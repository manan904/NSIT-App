//
//  ViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 22/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class HomeViewController: UIViewController {
    
   let ref = Database.database().reference()

    @IBOutlet weak var barButtonMenu: UIBarButtonItem!
    @IBOutlet weak var welcomeText: UILabel!
    
    var displayName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //To display User Name
        let uid = Auth.auth().currentUser?.uid
        ref.child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String:AnyObject]
            self.displayName = value?["Name"] as? String ?? ""
            print (self.displayName)
            self.welcomeText.text = "Hi " + self.displayName + " !"
        }) { (error) in
            print(error.localizedDescription)
        }
        

        revealViewController().rearViewRevealWidth = 250
        barButtonMenu.target = revealViewController()
        barButtonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
