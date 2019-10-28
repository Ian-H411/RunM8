//
//  User.swift
//  RunM8
//
//  Created by Ian Hall on 10/28/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class User {
    
    let userName: String
    
    let userID: String
    
    var runIDs: [String] = []
    var runs: [Run] = []
    
    var friendIDs: [String] = []
    var friends: [User] = []
    
    init(name: String, id: String = UUID().uuidString) {
        self.userName = name
        self.userID = id
    }
    init? (user: ImportUser) {
        self.userName = user.userName
        self.userID = user.id
    }
    
}

struct ImportUser: Codable {
    let userName: String
    
    let id: String
    
    let runIDs: [String]
    
    let friendIDs: [String]
}

