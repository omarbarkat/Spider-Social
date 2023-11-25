//
//  CommentTable.swift
//  swift-up
//
//  Created by Omar barkat on 10/11/2023.
//

import UIKit

class CommentTable: UITableViewCell {

    @IBOutlet weak var lblCommentBody: UILabel!
    @IBOutlet weak var lblDataPublish: UILabel!
    @IBOutlet weak var lblCommentOwnerUserName: UILabel!
    @IBOutlet weak var imgCommentOwnerPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
