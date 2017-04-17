//
//  TweetsViewController.swift
//  twitty
//
//  Created by bis on 4/16/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet] = []
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        reloadData(refreshControl: refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.estimatedRowHeight = 120
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tweetsTableView.insertSubview(refreshControl, at: 0)
        reloadData()
    }
    
    func reloadData(refreshControl: UIRefreshControl? = nil) {
        TwitterClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
            refreshControl?.endRefreshing()
        }) { (error: Error?) in
            print(error.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TweetsTableViewCell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetsTableViewCell", for: indexPath) as! TweetsTableViewCell
        cell.tweet = tweets[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tweetViewController = segue.destination as! TweetViewController
        let indexPath = tweetsTableView.indexPathForSelectedRow!
        let tweet = self.tweets[indexPath.row] as! Tweet
        tweetViewController.tweet = tweet
    }
    
}
