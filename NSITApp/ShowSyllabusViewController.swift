//
//  ShowSyllabusViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 26/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import Firebase

class ShowSyllabusViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var photoLink:String?
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Note that you can use variables to create child values
        //      let fileName = "graph.jpg"
        //       let spaceRef = imagesRef.child(fileName)
        // Create a reference to the file you want to download
        let photo = storageRef.child("Syllabus").child("IT").child(photoLink!)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        photo.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print (error)
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.image.image=image
            }
        }
}
    @IBAction func isBackButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
