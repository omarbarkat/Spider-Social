//
//  userProfileVC.swift
//  swift-up
//
//  Created by Omar barkat on 12/11/2023.
//

import UIKit
import Alamofire
import SwiftyJSON

class userProfileVC: UIViewController {
    var profileInfo : User!

    @IBOutlet weak var lblCountery: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblDataOfBirth: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUpdatedData: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserPhoto: UIImageView! {
        didSet {
            imgUserPhoto.makeCircularImage()
        }
    }
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgUserPhoto.SetImageFromURL(stringimg: profileInfo.picture ?? "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg")

        SetUpUI()
        PostAPI.getUserProfile(id: profileInfo.id) { userResponse in
            self.profileInfo = userResponse
            self.SetUpUI()
        }
    }
   
    func SetUpUI() {
        lblEmail.text =  profileInfo.email
        lblCountery.text = profileInfo.location?.country
        lblCity.text = profileInfo.location?.city
        lblUpdatedData.text = profileInfo.updatedDate
        lblGender.text = profileInfo.gender
        lblDataOfBirth.text = profileInfo.dateOfBirth
        lblPhoneNumber.text = profileInfo.phone
        lblUserName.text = profileInfo.title ?? "omar barkat" + "." + profileInfo.firstName + " " + profileInfo.lastName

    }
    
    

}
