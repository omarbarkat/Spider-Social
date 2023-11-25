//
//  ViewController.swift
//  swift-up
//
//  Created by Omar barkat on 07/11/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class PostsVC: UIViewController {
    
    var page : Int = 0
    var total = 0
    @IBOutlet weak var btnClose: UIButton! {
        didSet {
            if arrTags == nil {
                btnClose.isHidden = true
            }
        }
    }
    @IBOutlet weak var lblTageName: UILabel! {
        didSet {
            if let user = UserManger.loggedInUser {
                btnSignOut.isHidden = false
            } else {
                btnSignOut.isHidden = true
            }
        }
    }
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var viewTageNameContainer: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblHi: UILabel!
    var arrPosts:[Post] = []
    var post : Post!
    var arrTags : String?
    var PostTags : [String?] = []
    var tags : String? = ""
    @IBOutlet weak var loaderIndecatorView: NVActivityIndicatorView!
    @IBOutlet weak var tableViewPost: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        NotificationCenter.default.addObserver(self, selector: #selector(reloadpostsVC), name: NSNotification.Name(rawValue: "backToPosts"), object: nil)
                
        if UserManger.loggedInUser == nil {
            btnSignOut.isHidden = true
        }
        if let user = UserManger.loggedInUser {
            btnSignIn.isHidden = true

            lblHi.text = user.firstName + " " + user.lastName
        }else {
            lblHi.isHidden = true
        }
        tableViewPost.delegate = self
        tableViewPost.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(userTimeLine), name: NSNotification.Name(rawValue: "goToUserTimeLine"), object: nil)
        getPosts()
       
    }
    @objc func reloadpostsVC() {
        arrPosts = []
        page = 0
        getPosts()
    }
    // MARK: ACIONS
    func getPosts() {
        loaderIndecatorView.startAnimating()
        PostAPI.getAllPosts(page: page, tags: arrTags) {  postsResponse , totalResponse   in
            self.total = totalResponse
            if self.arrTags == self.arrTags {
                self.lblHeader.text = self.arrTags
            } else {
                self.viewTageNameContainer.isHidden = true
            }
            self.arrPosts.append(contentsOf: postsResponse)

            self.tableViewPost.reloadData()
            self.loaderIndecatorView.isHidden = true
        }
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOutSegue" {
            UserManger.loggedInUser = nil
        }
    }
    
    
    @IBAction func btnLike(_ sender: Any) {
      //  btnLikeActionNum.setTitle(" Likes \(post.likes + 1 )", for: .normal)
        
    }
    @objc func userTimeLine (notification : Notification) {
        if let cell = notification.userInfo?["cell"] as? postsCell {
            if let   indexpath = tableViewPost.indexPath(for: cell) {
                let post = arrPosts[indexpath.row]
                let vc = storyboard?.instantiateViewController(withIdentifier: "userTimeLine") as! userProfileVC
                
                vc.profileInfo = post.owner
                
                present(vc, animated: true, completion: nil)
            }
           
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "userTimeLine")
        present(vc!, animated: true, completion: nil)
    }
    
}
extension PostsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPost.dequeueReusableCell(withIdentifier: "postCell") as! postsCell
        let post = arrPosts[indexPath.row]
        cell.lblPostText.text = post.text
        cell.lblPostUserNama.text = "\(post.owner!.firstName) \(post.owner!.lastName)"
        cell.btnLike.setTitle(" Likes \(post.likes)", for: .normal)
   
        
        
        cell.btnLike.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        cell.btnComment.setImage(UIImage(systemName: "message.fill"), for: .normal)
        let imgStringUrl = post.image
        if let url = URL(string: imgStringUrl!) {
            if let data = try? Data(contentsOf: url) {
                cell.imgPostPhoto.image = UIImage(data: data)
            }
            // the logic of filling the user's image from url
        }
        cell.imgUserProfilePhoto.makeCircularImage()
        if let image = post.owner?.picture {
            cell.imgUserProfilePhoto.SetImageFromURL(stringimg: image )
        }
       
        let postUserPhotoString = post.owner?.picture
        cell.imgUserProfilePhoto.makeCircularImage()

        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 602
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let SelectedPost = arrPosts[indexPath.row]
        let VC = storyboard?.instantiateViewController(withIdentifier: "postDetails") as! postDetailsVC
        VC.post = SelectedPost
        present(VC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrPosts.count - 1 && arrPosts.count < total {
            page = page + 1
           getPosts()
        }
    }
}

