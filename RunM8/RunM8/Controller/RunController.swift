//
//  RunController.swift
//  RunM8
//
//  Created by Ian Hall on 10/29/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class RunController {
    
    static let shared = RunController()
    
    
    var selectedUser: User?
    
    func retrieveValueFromPlist(key: String, plistName: String) -> String {
        guard let filepath = Bundle.main.path(forResource: plistName, ofType: "plist") else { return "error" }
        let propertyList = NSDictionary.init(contentsOfFile: filepath)
        guard let value = propertyList?.value(forKey: key) as? String else { return "error" }
        return value
    }

    
    func createUser(name:String, completion: @escaping (Bool) -> Void ) {
        let user = User(name: name )
        selectedUser = user
        let jsonUser = ImportUser(userName: user.userName, id: user.userID, runIDs: user.runIDs, friendIDs: user.friendIDs)
        guard let baseURL = URL(string: "https://runm8-a2d91.firebaseio.com/") else {return}
        let apikey = retrieveValueFromPlist(key: "RunM8Key", plistName: "APIKeys")
        let queryItem = URLQueryItem(name: "key", value: apikey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [queryItem]
        guard var url = urlComponents?.url else {return}
        url.appendPathExtension("json")
        print(url)
        var request = URLRequest(url: url)
        var userData: Data?
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(jsonUser)
            userData = data
        } catch {
            print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
        }
        guard let userDataUn = userData else {return}
        request.httpBody = userDataUn
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }
    }
    
    func retrieveUser() {
        
    }
    
    func updateUser() {
        
    }
    
    func deleteUser() {
        
    }
}
