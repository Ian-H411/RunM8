//
//  ViewController.swift
//  RunM8
//
//  Created by Ian Hall on 10/30/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        UserController.shared.retrieveUser(userName: "success") { (success) in
            if success{
                guard let user = UserController.shared.selectedUser else {return}
                print(user.userName)
                UserController.shared.updateUser(user: user, newUserName: "dave") { (success) in
                    if success {
                        print("hoohrah")
                    }
                }
            } else {
                print("error")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
