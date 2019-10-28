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
    
    //expressed as an array of tuples (lat,long)
    var route: [(Int,Int)]
    
    let elevation: Int
    
    init(time: Int, elevation: Int, route: [(Int,Int)], date: Date = Date(), name: String ) {
        self.time = time
        self.date = date
        self.name = name
        self.elevation = elevation
        self.route = route
    }
    
}
