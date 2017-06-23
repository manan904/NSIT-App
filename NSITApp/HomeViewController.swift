//
//  ViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 22/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var barButtonMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barButtonMenu.target = revealViewController()
        barButtonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

