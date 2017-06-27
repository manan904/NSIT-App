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


class SignUpViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate{
    
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var rollNo: UITextField!
    @IBOutlet weak var branch: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!

    var optionsA = ["" , "COE", "IT", "ECE", "ICE", "MPAE", "ME","BT"]
    var optionsB = ["" , "1", "2", "3"]
    var optionsC = ["" , "1st Year", "2nd Year"]
    var pickerDataSource = ["White", "Red", "Green", "Blue"]
    
  //  let optionsA = ["Sunday" ,"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
 //   let optionsB = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    // variables to gold current data
    var picker : UIPickerView!
    var activeTextField = 0
    var activeTF : UITextField!
    var activeValue = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        branch.delegate = self
        section.delegate = self
        year.delegate = self
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let firstName = self.firstName.text
        let email = self.emailID.text
        let rollNo = self.rollNo.text
        let year = self.year.text
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
                
                let values = ["Name": firstName , "Email": email , "RollNo": rollNo ,"Year": year , "Branch": branch , "Section": section]
                
                
                
                
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // return number of elements in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // get number of elements in each pickerview
        switch activeTextField {
        case 1:
            return optionsA.count
        case 2:
            return optionsB.count
        case 3:
            return optionsC.count

        default:
            return 0
        }
    }
    
    // return "content" for picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // return correct content for picekr view
        switch activeTextField {
        case 1:
            return optionsA[row]
        case 2:
            return optionsB[row]
        case 3:
            return optionsC[row]
        default:
            return ""
        }
        
    }
    
    // get currect value for picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // set currect active value based on picker view
        switch activeTextField {
        case 1:
            activeValue = optionsA[row]
        case 2:
            activeValue = optionsB[row]
        case 3:
            activeValue = optionsC[row]
        default:
            activeValue = ""
        }
    }
    
    // start editing text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // set up correct active textField (no)
        switch textField {
        case branch:
            activeTextField = 1
        case section:
            activeTextField = 2
        case year:
            activeTextField = 3
        default:
            activeTextField = 0
        }
        // set active Text Field
        activeTF = textField
        
        if activeTextField != 0 {
        self.pickUpValue(textField: textField)
        }
    }
    
    // show picker view
    func pickUpValue(textField: UITextField) {
        
        // create frame and size of picker view
        picker = UIPickerView(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 216)))
        
        // deletates
        picker.delegate = self
        picker.dataSource = self
        
        // if there is a value in current text field, try to find it existing list
        if let currentValue = textField.text {
            
            var row : Int?
            
            // look in correct array
            switch activeTextField {
            case 1:
                row = optionsA.index(of: currentValue)
            case 2:
                row = optionsB.index(of: currentValue)
            default:
                row = nil
            }
            
            // we got it, let's set select it
            if row != nil {
                picker.selectRow(row!, inComponent: 0, animated: true)
            }
        }
        
        picker.backgroundColor = UIColor.white
        textField.inputView = self.picker
        
        // toolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.white
        toolBar.sizeToFit()
        
        // buttons for toolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // done
    func doneClick() {
        activeTF.text = activeValue
        activeTF.resignFirstResponder()
        
    }
    
    // cancel
    func cancelClick() {
        activeTF.resignFirstResponder()
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
