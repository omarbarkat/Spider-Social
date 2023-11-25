//
//  SignInVC.swift
//  swift-up
//
//  Created by Omar barkat on 15/11/2023.
//

import UIKit


class SignInVC: UIViewController {

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblLastName: UITextField!
    @IBOutlet weak var lblFirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLastName.text = "omar"
        self.lblFirstName.text = "barkat"
        
        btnSignIn.layer.cornerRadius = 15
    }
    
   @IBAction func btnSkip(_ sender: Any) {
  //      let vc = self.storyboard?.instantiateViewController(withIdentifier: "posts") as? ViewController
    //    self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnSignIN(_ sender: Any) {
        PostAPI.signInUser(firstName: lblFirstName.text!, lastName: lblLastName.text!) { user, errorMsg in
            if let messeg = errorMsg {
                let alert = UIAlertController(title: "error", message: messeg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "error", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                if let loggedIn = user {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") 
                    UserManger.loggedInUser = loggedIn
                    self.present(vc!, animated: true, completion: nil)
                    let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "createPost")
                    UserManger.loggedInUser = loggedIn
                    self.present(vc2!, animated: true, completion: nil)
                    
                }
                
            }
        }
    }


}
