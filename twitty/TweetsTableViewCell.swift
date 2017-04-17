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
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    
    weak var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            authorNameLabel.text = tweet.authorName
            authorScreenNameLabel.text = tweet.authorScreenName
            if let timestamp = tweet.timestamp {
                let df = DateFormatter()
                df.dateFormat = "hh"
                createdTimeLabel.text = "\(df.string(from: timestamp)) h"
            }
            if let profileImageURL = tweet.authorProfileURL {
                profileImageView.setImageWith(profileImageURL)
            }
            if let retweetCount = tweet.retweetCount {
                if retweetCount > 0 {
                    retweetCountLabel.text = "\(retweetCount)"
                }
            }
            if let favoriteCount = tweet.favoriteCount {
                if favoriteCount > 0 {
                    favoriteCountLabel.text = "\(favoriteCount)"
                }
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
