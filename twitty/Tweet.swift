//
//  Tweet.swift
//  twitty
//
//  Created by bis on 4/16/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var idStr: String?
    var authorScreenName: String?
    var authorName: String?
    var authorProfileURL: URL?
    var retweetCount: Int!
    var favoriteCount: Int!
    
    init(tweetDictionary: NSDictionary) {
        text = tweetDictionary["text"] as? String
        idStr = tweetDictionary["id_str"] as? String
        retweetCount = tweetDictionary["retweet_count"] as? Int ?? 0
        favoriteCount = tweetDictionary["favorite_count"] as? Int ?? 0
        if let author = tweetDictionary["user"] as? NSDictionary {
            authorScreenName = author["screen_name"] as? String
            authorName = author["name"] as? String
            if let url = author["profile_image_url"] as? String {
                authorProfileURL = URL(string: url)
            }
        }
    }
    
    static func fromDictionaries(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets: [Tweet] = []
        for dict in dictionaries {
            tweets.append(Tweet(tweetDictionary: dict))
        }
        return tweets
    }
}
