//
//  TwitterClient.swift
//  twitty
//
//  Created by bis on 4/16/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let twitterBaseURL = "https://api.twitter.com"
    
    static let sharedInstance: TwitterClient! = TwitterClient(
        baseURL: URL(string: twitterBaseURL),
        consumerKey: "rUeuxpaQjrOfFVyi7ZpUmoTVz",
        consumerSecret: "ALQcv2ZQChXpzyCbZ3Gjbw4RaSsOzDoRuYzRNi4bfmda8BvRpz")
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken:BDBOAuth1Credential?) in
            if let accessToken = accessToken {
                print("got access token \(accessToken)")
            }
        },
        failure: { (error: Error?) in
            if let error = error {
                print("login: error \(error)")
        }})
    }
    
    func login() {
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(
            withPath: "oauth/request_token", method: "GET",
            callbackURL: URL(string: "twitty://oauth_callback"),
            scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
                if let token = requestToken?.token{
                    UIApplication.shared.open(URL(string: "\(TwitterClient.twitterBaseURL)/oauth/authorize?oauth_token=\(token)")!,
                                              options: [:], completionHandler: nil)
                }
                
        }) { (error: Error?) in
            print("\(error.debugDescription)")
        }
    }
}
