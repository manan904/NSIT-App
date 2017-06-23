//
//  MessageViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 22/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit

class TTViewController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        revealViewController().rearViewRevealWidth = 200
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
