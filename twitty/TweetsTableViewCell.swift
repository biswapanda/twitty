//
//  TweetsTableViewCell.swift
//  twitty
//
//  Created by bis on 4/17/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorScreenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    
    weak var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            authorNameLabel.text = tweet.authorName
            if let profileImageURL = tweet.authorProfileURL {
                profileImageView.setImageWith(profileImageURL)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
