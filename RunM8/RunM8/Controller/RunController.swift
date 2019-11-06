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
    
    //MARK: - Helper Functions
    func retrieveValueFromPlist(key: String, plistName: String) -> String {
        guard let filepath = Bundle.main.path(forResource: plistName, ofType: "plist") else { return "error" }
        let propertyList = NSDictionary.init(contentsOfFile: filepath)
        guard let value = propertyList?.value(forKey: key) as? String else { return "error" }
        return value
    }
    
    //MARK: - ADD A RUN
    func addARun(name: String, route: [CLLocation], time: Int, completion: @escaping (Bool) -> Void ) {
        guard let user = UserController.shared.selectedUser else {return}
        let startingElevation: Int = Int(route[0].altitude)
        var highestElevation: Int = 0
        var clPoints = [[Double]]()
        for point in route {
            //set the highest elevation if current point is higher
            if highestElevation < Int(point.altitude) {
                highestElevation = Int(point.altitude)
            }
            clPoints.append([point.coordinate.latitude,point.coordinate.longitude])
        }
        let totalElevationGain = startingElevation.distance(to: highestElevation)
        let run = ImportRun(time: time, date: "\(Date())", name: name, elevation: totalElevationGain, route: clPoints)
        //add it locally before the push up
        guard let runObj = Run(run: run, user: user) else {completion(false); print("COULD NOT CONVERT A RUN INTO A RUNOBJ");return}
        pushRunToDataBase(run: run, runObject: runObj) { (success) in
            completion(success)
        }
    }
    
    fileprivate func pushRunToDataBase(run: ImportRun, runObject: Run, completion: @escaping (Bool) -> Void) {
        guard var baseURL = URL(string: "https://runm8-a2d91.firebaseio.com/") else {completion(false);print("could not create url");return}
        baseURL.appendPathComponent("runs")
        let apikey = retrieveValueFromPlist(key: "RunM8Key", plistName: "APIKeys")
        let queryItem = URLQueryItem(name: "key", value: apikey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [queryItem]
        guard var url = urlComponents?.url else {completion(false);print("url could not be pulled from urlcomponenets");return}
        url.appendPathExtension("json")
        var request = URLRequest(url: url)
        var runData: Data?
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(run)
            runData = data
        } catch {
            print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
            completion(false)
            return
        }
        guard let runDataUnwrapped = runData else {return}
        request.httpBody = runDataUnwrapped
        request.httpMethod = "PUT"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let name = try decoder.decode([String:String].self, from: data)
                runObject.id = name["name"] ?? "NO ID"
                completion(true)
                return
            } catch {
                print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    
    
    //MARK: - UPDATE A RUN
    
    
    
    
    //MARK: - DELETE A RUN
    
    
    
    //MARK: - RETRIEVE RUNS
    
    
    
    
    
}
