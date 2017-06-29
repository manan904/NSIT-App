//
//  SyllabusViewController.swift
//  NSITApp
//
//  Created by Manan Manwani on 23/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit
import  Firebase

class SyllabusViewController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    let databaseRef = Database.database().reference()
    
    var Subjects:Array = [String]()
    var SubjectRef:Array = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        revealViewController().rearViewRevealWidth = 250
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
 /*
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
       let storageRef = storage.reference()
        
        // Note that you can use variables to create child values
  //      let fileName = "graph.jpg"
 //       let spaceRef = imagesRef.child(fileName)
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("Graph.jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print (error)
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.img.image=image
            }
        }
        

    }
*/
         let userReference = self.databaseRef.child("Syllabus").child("2nd Year").child("IT")
        
   //     let values = ["1":"1.png" , "2":"2.png" , "3":"3.png" , "4":"4.png" , "5":"5.png"]
           var values:NSDictionary = [:]
        
        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            values = (snapshot.value as? NSDictionary)!
            self.Subjects = Array(values.allKeys) as! [String]
            self.SubjectRef = Array(values.allValues) as! [String]
            print(values)
            [self.tableView .reloadData()]
        }) { (error) in
            print(error.localizedDescription)
        }
        
       /* userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print (error!)
                return
            }
        }) */
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Subjects.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectsTableViewCell", for: indexPath) as! SubjectsTableViewCell
        
        cell.subjectName.text! = Subjects[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let VC=UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowSyllabusViewController") as! ShowSyllabusViewController
        
        VC.photoLink = SubjectRef[indexPath.row]
        
        self.present(VC, animated: true, completion: nil)
        
    }

}
