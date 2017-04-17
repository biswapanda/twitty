//
//  ComposeTweetViewController.swift
//  twitty
//
//  Created by bis on 4/17/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorScreenNameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
   
    @IBAction func tweetTapped(_ sender: Any) {
        TwitterClient.sharedInstance.postMessage(
            message: messageTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser!
        authorNameLabel.text = user.name
        authorScreenNameLabel.text = user.screenName
        if let imageUrl = user.profileURL {
            profileImageView.setImageWith(imageUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
