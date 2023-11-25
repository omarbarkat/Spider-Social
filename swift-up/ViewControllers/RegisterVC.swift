//
//  RegisterVC.swift
//  swift-up
//
//  Created by Omar barkat on 14/11/2023.
//

import UIKit
import IQKeyboardManagerSwift
class RegisterVC: UIViewController {

    @IBOutlet weak var btnSumit: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSumit.layer.cornerRadius = 15

    }
    
    @IBAction func btnGoToSignIn(_ sender: Any) {

        dismiss(animated: true, completion: nil)  
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        PostAPI.registerUser(firstName: txtFirstName.text!, lastName: txtLastName.text!, email: txtEmail.text!) { user, errormsg in
            if errormsg != nil {
                let alert = UIAlertController(title: "Error", message: errormsg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .destructive, handler: nil))
               self.present(alert, animated: true, completion: nil)
            } else {
                    let alert = UIAlertController(title: "Success", message: "Account Created", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
            }
        }
        
                             }
    
  
}

