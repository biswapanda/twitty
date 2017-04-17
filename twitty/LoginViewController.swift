//
//  LoginViewController.swift
//  twitty
//
//  Created by bis on 4/16/17.
//  Copyright © 2017 biswa. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginTaped(_ sender: Any) {
        let client = TwitterClient.sharedInstance
        client.login(success: { (user: User) in
            User.currentUser = user
            print("login success..")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: Error?) in
            let errorText = error?.localizedDescription ?? "unknow error"
            print("Error: \(errorText)")
        }
    }

}
