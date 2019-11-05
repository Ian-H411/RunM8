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
        let elevations = route.map({Int($0.altitude)})
        
        let run = ImportRun(time: time, date: "\(Date())", name: String, elevation: elevations, route: <#T##[[Int]]#>)
    }
    
    
    //MARK: - UPDATE A RUN
    
    
    
    
    //MARK: - DELETE A RUN
    
    
    
    //MARK: - RETRIEVE RUNS
    
    
    
    
    
}
