//
//  RunController.swift
//  RunM8
//
//  Created by Ian Hall on 11/4/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import CoreLocation
class RunController {
    
    let shared = RunController()
    
    //MARK: - ADD A RUN
    func addARun(name: String, route: [CLLocation], time: Int, completion: @escaping (Bool) -> Void ) {
        guard let user = UserController.shared.selectedUser else {return}
        var startingElevation: Int = Int(route[0].altitude)
        var highestElevation: Int = 0
        var elevationGained: Int = 0
        let clPoints = [[Double]]()
        for point in route {
            //set the highest elevation if current point is higher
            if highestElevation < Int(point.altitude) {
                highestElevation = Int(point.altitude)
            }
        }
        let run = ImportRun(time: time, date: "\(Date())", name: name, elevation: <#T##Int#>, route: <#T##[[Int]]#>)
        
    }
    
    
    //MARK: - UPDATE A RUN
    
    
    
    
    //MARK: - DELETE A RUN
    
    
    
    //MARK: - RETRIEVE RUNS
    
    
    
    
    
}
