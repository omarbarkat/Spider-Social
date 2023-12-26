//
//  HomePostTv.swift
//  swift-up
//
//  Created by Omar barkat on 08/11/2023.
//

import UIKit

class postsCell: UITableViewCell {

    var post : Post?
    @IBOutlet weak var lblTextPost: UILabel!
    @IBOutlet weak var stackViewToUserTimeline: UIStackView! {
        didSet {
            stackViewToUserTimeline.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goTOUserTimeLine)))
        }
    }
    @IBOutlet weak var lblPostText: UILabel!
    @IBOutlet weak var CollectionViewPostTags: UICollectionView!
    @IBOutlet weak var imgUserProfilePhoto: UIImageView!
    @IBOutlet weak var lblPostUserNama: UILabel!
    @IBOutlet weak var imgPostPhoto: UIImageView!
   
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton! {
        didSet {
            btnComment.layer.cornerRadius = 15
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func goTOUserTimeLine () {
        NotificationCenter.default.post(name: NSNotification.Name("goToUserTimeLine"), object: nil, userInfo: ["cell":self])
    }

    @IBAction func btnLike(_ sender: Any) {
        if let user = UserManger.loggedInUser {
            btnLike.setTitle("Likes \((post?.likes) ?? 0 + 1)", for: .normal)
        }
       
    }
}
