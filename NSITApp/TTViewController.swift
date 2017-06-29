//
//  MessageViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 22/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase

class TTViewController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var TTimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        revealViewController().rearViewRevealWidth = 250
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Note that you can use variables to create child values
        //      let fileName = "graph.jpg"
        //       let spaceRef = imagesRef.child(fileName)
        // Create a reference to the file you want to download
        let photo = storageRef.child("TimeTable").child("2nd Year").child("IT.png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        photo.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print (error)
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.TTimage.image=image
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
