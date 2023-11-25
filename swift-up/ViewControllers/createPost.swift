//
//  createPost.swift
//  swift-up
//
//  Created by Omar barkat on 22/11/2023.
//

import UIKit

class createPost: UIViewController {
    var user = UserManger.loggedInUser
    var post : Post?
    
    // MARK: OUTLETS
    @IBOutlet weak var barItem: UITabBarItem!
    @IBOutlet weak var btnPublish: UIButton! {
        didSet {
            btnPublish.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var txtPostPhotoURL: UITextField!
    @IBOutlet weak var imgPostPhoto: UIImageView!
    @IBOutlet weak var txtPostTags: UITextField!
    @IBOutlet weak var txtPostBodyText: UITextField!
    @IBOutlet weak var lblOwnerUserName: UILabel!
    @IBOutlet weak var imgOwnerProfilePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let user = UserManger.loggedInUser
        lblOwnerUserName.text = user!.firstName + " " + user!.lastName
        if let image = user?.picture {
                imgOwnerProfilePhoto.SetImageFromURL(stringimg: image)
                imgOwnerProfilePhoto.makeCircularImage()
            }
        
   //     self.txtPostBodyText.text = "txt"
        self.txtPostTags.text = "tags"
        self.txtPostPhotoURL.text = "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg"

        if let user = UserManger.loggedInUser {
            lblOwnerUserName.text = user.firstName
            if   let imgprofile = user.picture {
                imgOwnerProfilePhoto.SetImageFromURL(stringimg: imgprofile)
                imgOwnerProfilePhoto.makeCircularImage()

            }

        }
  

    }
    
    @IBAction func btnCreatePost(_ sender: Any) {
        if let user = UserManger.loggedInUser {
            lblOwnerUserName.text = user.firstName + " " + user.lastName
            PostAPI.createPost(likes: 0, tags: txtPostTags.text!, text: txtPostBodyText.text!, owner:user.id , image: txtPostPhotoURL.text! ) { postResponse, errorResponse in
              //  print(postResponse)
                NotificationCenter.default.post(name: NSNotification.Name("backToPosts"), object: nil, userInfo: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "posts")
                self.present(vc!, animated: true, completion: nil)
            }
        } else   {
            let alert = UIAlertController(title: "alert", message: "you must sign in to add post", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancle", style: .cancel, handler: nil))
        }
      
    }
    
   
  

}
