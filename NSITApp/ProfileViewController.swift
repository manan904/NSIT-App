//
//  ProfileViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 27/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var barButtonMenu: UIBarButtonItem!
    
    let ref = Database.database().reference()
    var stringName:String = ""
    var stringrollNo:String = ""
    var stringYear:String = ""
    var stringBranch:String = ""

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rollNo: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var branch: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = Auth.auth().currentUser?.uid
        ref.child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String:AnyObject]
            self.stringName = value?["Name"] as? String ?? ""
            self.name.text = self.stringName
            self.stringName = value?["RollNo"] as? String ?? ""
            self.rollNo.text = self.stringName
            self.stringName = value?["Year"] as? String ?? ""
            self.year.text = self.stringName
            self.stringName = value?["Branch"] as? String ?? ""
            self.branch.text = self.stringName
        }) { (error) in
            print(error.localizedDescription)
        }
        
        revealViewController().rearViewRevealWidth = 250
        barButtonMenu.target = revealViewController()
        barButtonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
    }
}
