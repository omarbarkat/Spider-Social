//
//  postDetailsVC.swift
//  swift-up
//
//  Created by Omar barkat on 10/11/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class postDetailsVC: UIViewController {
    var arrComments : [Comment] = []
    var arrPosts:[Post] = []

    var post : Post!
    //MARK: OUTLETS
    @IBOutlet weak var txtFieldComment: UITextField!
    @IBOutlet weak var loaderIndecatorView: NVActivityIndicatorView!
    @IBOutlet weak var imgUserProfilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblPostTags: UILabel!
    @IBOutlet weak var NewCommentStackView: UIStackView!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var lblPostBody: UILabel!
    @IBOutlet weak var imgPostBodyPhoto: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnLikes: UIButton!
    @IBOutlet weak var btnComments: UIButton!
    //MARK: LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let joindString = post.tags!.joined(separator: "# ")
        lblPostTags.text = "#\(joindString)"
       
        lblUserName.text = post.owner!.firstName + " " + post.owner!.lastName
        lblPostBody.text = post.text
        btnLikes.setTitle(" Likes \(post.likes)", for: .normal)
        btnLikes.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        btnComments.setImage(UIImage(systemName: "message.fill"), for: .normal)
      
        
        if let image = post.owner?.picture {
            imgUserProfilePhoto.SetImageFromURL(stringimg: image)
        }
        
        imgUserProfilePhoto.layer.cornerRadius = imgUserProfilePhoto.layer.frame.width / 2
        if let image = post.image {
            imgPostBodyPhoto.SetImageFromURL(stringimg: image)
        }
        //COMMENT :
        getPostDetialsReload()
    }
    func getPostDetialsReload () {
        loaderIndecatorView.startAnimating()

        PostAPI.getPostDetails(post: post) { commentResponse in
                self.arrComments = commentResponse
            self.tableView.reloadData()
            self.loaderIndecatorView.isHidden = true
        }
    }
    //MARK: ACTIONS
    
    @IBAction func btnSendComment(_ sender: Any) {
        if UserManger.loggedInUser == nil {
            let alert = UIAlertController(title: "Alert", message: "you must sign in to comment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        if let user = UserManger.loggedInUser {
            loaderIndecatorView.startAnimating()
            PostAPI.createComment(message: txtFieldComment.text!, owner: user.id, post: post.id)  {
            self.getPostDetialsReload()
            self.txtFieldComment.text = ""
        }
            
        }
    
    }
    @IBAction func btnLikeAction(_ sender: Any) {
        btnLikes.setTitle(" Likes \(post.likes + 1 )", for: .normal)
    }
    @IBAction func btnClosePage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension postDetailsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentTable
        let post = arrComments[indexPath.row]
        cell.lblCommentBody.text = post.message
        
        cell.lblCommentOwnerUserName.text = "\(post.owner.firstName) \(post.owner.lastName)"
        cell.lblDataPublish.text = post.publishDate
  
        if let imgStringUrl = post.owner.picture {
            cell.imgCommentOwnerPhoto.SetImageFromURL(stringimg: imgStringUrl)

        }
        cell.imgCommentOwnerPhoto.makeCircularImage()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}
