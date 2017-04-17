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
    static let consumerKey = "rUeuxpaQjrOfFVyi7ZpUmoTVz"
    static let consumerSecret = "ALQcv2ZQChXpzyCbZ3Gjbw4RaSsOzDoRuYzRNi4bfmda8BvRpz"

    static let sharedInstance: TwitterClient = TwitterClient(baseURL: URL(string: twitterBaseURL),
                                                             consumerKey: consumerKey,
                                                             consumerSecret: consumerSecret)
    var logginSuccsessFunc: ((User) -> ())?
    var loggingErrorFunc: ((Error?) -> ())?
    
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: "oauth/access_token",
                         method: "POST",
                         requestToken: requestToken,
                         success: {(accessToken:BDBOAuth1Credential?) in
            if let accessToken = accessToken {
                self.currentAccount()
            }
        },
        failure: { (error: Error?) in
            if let error = error {
                self.loggingErrorFunc?(error)
        }})
    }
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let user = User(userDictionary: response as! NSDictionary)
                self.logginSuccsessFunc?(user)
        }) { (task: URLSessionDataTask?, error: Error) in
            self.loggingErrorFunc?(error)
        }
    }
    
    func login(success: @escaping (User) -> (), error: @escaping (Error?) -> ()) {
        logginSuccsessFunc = success
        loggingErrorFunc = error
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(
            withPath: "oauth/request_token", method: "GET",
            callbackURL: URL(string: "twitty://oauth_callback"),
            scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
                if let token = requestToken?.token{
                    let authUrl = "\(TwitterClient.twitterBaseURL)/oauth/authorize?oauth_token=\(token)"
                    UIApplication.shared.open(URL(string: authUrl)!, options: [:], completionHandler: nil)
                }
                
        }) { (error: Error?) in
            self.loggingErrorFunc?(error)
        }
    }
}
