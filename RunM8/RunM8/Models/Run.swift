//
//  Run.swift
//  RunM8
//
//  Created by Ian Hall on 10/28/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class Run {
    
    let time: Int
    
    let date: Date
    
    var name: String
    
    let user: User
    let userReferenceID: String
    
    ///expressed as an array of arrays [lat,long]
    var route: [[Int]]
    
    let elevation: Int
    
    init(time: Int, elevation: Int, route: [[Int]], date: Date = Date(), name: String, user: User ) {
        self.time = time
        self.date = date
        self.name = name
        self.elevation = elevation
        self.route = route
        self.userReferenceID = user.userID
        self.user = user
    }
    
    init?(run: ImportRun, user: User) {
        self.time = run.time
        self.date = Date()
        self.name = run.name
        self.elevation = run.elevation
        self.route = run.route
        self.userReferenceID = user.userID
        self.user = user
    }
    
}

struct ImportRun: Codable {
    
    let time: Int
    
    let date: String
    
    let name: String
    
    let elevation: Int
    
    let route: [[Int]]
}

