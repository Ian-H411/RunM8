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
    //MARK: - HELPER FUNCTIONS
    func retrieveValueFromPlist(key: String, plistName: String) -> String {
        guard let filepath = Bundle.main.path(forResource: plistName, ofType: "plist") else { return "error" }
        let propertyList = NSDictionary.init(contentsOfFile: filepath)
        guard let value = propertyList?.value(forKey: key) as? String else { return "error" }
        return value
    }

    //MARK: - CREATE
    func createUser(name:String, completion: @escaping (Bool) -> Void ) {
        let user = User(name: name )
        let jsonUser = ImportUser(userName: user.userName, id: user.userID, runIDs: user.runIDs, friendIDs: user.friendIDs)
        guard var baseURL = URL(string: "https://runm8-a2d91.firebaseio.com/") else {completion(false);print("could not create url");return}
        baseURL.appendPathComponent("users")
        let apikey = retrieveValueFromPlist(key: "RunM8Key", plistName: "APIKeys")
        let queryItem = URLQueryItem(name: "key", value: apikey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [queryItem]
        guard var url = urlComponents?.url else {completion(false);print("url could not be pulled from urlcomponenets");return}
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
        guard let userDataUn = userData else {completion(false); print("UserData was nil");return}
        request.httpBody = userDataUn
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
            if let response = response {
                print(response)
            }
            if let _ = data {
                completion(true)
            }
        }.resume()
    }
    
    //MARK: - READ
    func retrieveUser(userName: String, completion: @escaping (Bool) -> Void) {
        guard var baseURL = URL(string: "https://runm8-a2d91.firebaseio.com/") else {completion(false);print("could not create url");return}
        baseURL.appendPathComponent("users")
        let apikey = retrieveValueFromPlist(key: "RunM8Key", plistName: "APIKeys")
        let queryApiItem = URLQueryItem(name: "key", value: apikey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [queryApiItem]
        guard let url = urlComponents?.url else {return}
        var request = URLRequest(url: url.appendingPathComponent("json"))
        request.httpBody = nil
        request.httpMethod = "GET"
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
                let profileArrays = try decoder.decode([ImportUser].self, from: data)
                guard let userImport = profileArrays.first else { completion(false); print("No usernames found");return}
                let user = User(user: userImport)
                self.selectedUser = user
                completion(true)
            } catch {
                print("there was an error in \(#function) :\(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    //MARK: - UPDATE
    func updateUser() {
        
    }
    //MARK: - DELTETE
    func deleteUser() {
        
    }
}
