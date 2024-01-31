//
//  FeedCell.swift
//  InstagrClone
//
//  Created by Test on 31.01.24.
//

import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var documentIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
    }
    
    
}
