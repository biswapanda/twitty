//
//  User.swift
//  twitty
//
//  Created by bis on 4/16/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagline: String?
    
    init(userDictionary: NSDictionary) {
        name = userDictionary["name"] as? String
        screenName = userDictionary["screen_name"] as? String
        tagline = userDictionary["description"] as? String
        if let profileImageUrl = userDictionary["profile_image_url_https"] as? String{
            profileURL = URL(string: profileImageUrl)
        }
    }
}
