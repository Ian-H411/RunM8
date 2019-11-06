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
    var route: [[Double]]
    
    let elevation: Int
    
    var id: String
    
    init(time: Int, elevation: Int, route: [[Double]], date: Date = Date(), name: String, user: User, id: String = UUID().uuidString ) {
        self.time = time
        self.date = date
        self.name = name
        self.elevation = elevation
        self.route = route
        self.userReferenceID = user.userID
        self.user = user
        self.id = id
    }
    
    init?(run: ImportRun, user: User, id: String = UUID().uuidString) {
        self.time = run.time
        self.date = Date()
        self.name = run.name
        self.elevation = run.elevation
        self.route = run.route
        self.userReferenceID = user.userID
        self.user = user
        self.id = id
    }
    
}

struct ImportRun: Codable {
    
    let time: Int
    
    let date: String
    
    let name: String
    
    let elevation: Int
    
    let route: [[Double]]
}

