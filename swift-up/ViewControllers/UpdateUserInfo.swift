//
//  UpdateUserInfo.swift
//  swift-up
//
//  Created by Omar barkat on 24/11/2023.
//

import UIKit
import NVActivityIndicatorView

class UpdateUserInfo: UIViewController {

    
    // MARK: OUTLETS
    @IBOutlet weak var btnSumit: UIButton!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtUserImageURL: UITextField!
    @IBOutlet weak var txtUserPhoneNum: UITextField!
    @IBOutlet weak var txtUserFirstName: UITextField!
    @IBOutlet weak var imgUserPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSumit.layer.cornerRadius = 15
        getInfo()
        
        
    }
    func getInfo() {
        if let user = UserManger.loggedInUser {
            lblUserName.text = user.firstName + " " + user.lastName
            if let image = user.picture {
                imgUserPhoto.SetImageFromURL(stringimg: image)
                imgUserPhoto.makeCircularImage()
            }
            
        }
    }
    // MARK: ACTIONS
    @IBAction func btnSumit(_ sender: Any) {
        loaderView.startAnimating()
        if let loggedinUser = UserManger.loggedInUser {
            
            PostAPI.UpdateUserIfon(firstName: txtUserFirstName.text!, phone: txtUserPhoneNum.text!, ImageURL: txtUserImageURL.text!, userId: loggedinUser.id) { udpateRespnse, msgError in
                self.loaderView.isHidden = true
                if let user = udpateRespnse {
                   // self.txtUserImageURL.text =
                    if   self.lblUserName.text != nil {
                        self.lblUserName.text = user.firstName
                    }
                    if let img = user.picture {
                        self.imgUserPhoto.SetImageFromURL(stringimg: img)
                        self.imgUserPhoto.makeCircularImage()
                    }
                }
            }
        }
      
    }
    

}
