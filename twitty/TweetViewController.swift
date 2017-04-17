//
//  TweetViewController.swift
//  twitty
//
//  Created by bis on 4/17/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    
    weak var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tweet == nil {
            return
        }
        
        if let tweetText = tweet.text {
            tweetLabel.text = tweetText
        }
        
        if let authorName = tweet.authorName {
            nameLabel.text = authorName
        }
        
        nameLabel.text = tweet.authorName
        screenNameLabel.text = tweet.authorScreenName!
        if let timestamp = tweet.timestamp {
            let df = DateFormatter()
            df.dateFormat = "hh"
            timestampLabel.text = "\(df.string(from: timestamp)) h"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
