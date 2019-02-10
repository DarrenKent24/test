//
//  ViewController.swift
//  test
//
//  Created by Darren Kent on 2019-02-10.
//  Copyright © 2019 TEN 15 APPS INC. All rights reserved.
//

import UIKit

struct User : Codable{
   
    let userName : String?
    let firstName : String?
    let lastName : String?
    let currentPassowrd : String?
    let newPassword : String?
}


class ViewController: UIViewController {

    
    //iOS Code Challenge:***indeed auto formats this, so apologies for the terrible syntax****
    //Create an iOS application that has a representation of the attached image in this question:
    //Requirements:
    
    // Note: Authentication is done with an JWT authentication token.
    // Assume you have a valid token.
    
    // 1. On or before the view is loaded a mock network call will be made to retrieve the profile Information. The endpoint is "https://api.foo.com/profiles/mine" JSON return is in the following format: { "message": "User Retrieved", "data": { "firstName": "Johnny B", "userName": "iOS User", "lastName": "Goode" } } .
    
    // 2. Both "Save Changes" buttons will make a mock network call to the following endpoints:
    
    //Basic Information: POST "https://api.foo.com/profiles/update" - required parameters: firstName, lastName - successful return will be in the format of:
    // { "message": "User Retrieved", "data": { "firstName": "Johnny B", "userName": "iOS User", "lastName": "Goode" } }
    
    //Password Change: POST "https://api.foo.com/password/change" - required parameters: current password, new password, password confirmation - successful return will be in the format of:
    // { "data": { "code": "string", "message": "Password Changed", "exceptionName": null }
    
    // 3. Error handling for the mock returns are required.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }

    func fetchData(){
        
        let urlString = "https://api.foo.com/profiles/mine"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                return
                
            } else {
                
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,AnyObject>
                    
                    for (key, value) in parsedData {
                        
                        if key == "message" {
                            
                            if let message = (value as? String) {
                                
                                print(message)
                                //Do something with message.
                            }
                        }
                        
                        if key == "data" {
                            
                            if let jsonData = (value as? String) {
                                
                                let userData = Data(jsonData.utf8)
                                
                                do {
                                    
                                    let decoder = JSONDecoder()
                                    _ = try decoder.decode(User.self, from: userData)
                                    //Do something with User data.
                                    
                                } catch let error as NSError {
                                    
                                    print(error.localizedDescription)
                                    return
                                }
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    
                    print(error.localizedDescription)
                    return
                }
            }
            
            }.resume()
    }

    @IBAction func saveUserInfo(_ sender: Any) {
        
        sendUserInfo(userName: "iOS User", firstName: "Johnny B", lastName: "Goode")
    }
    
    @IBAction func saveUserPassword(_ sender: Any) {
        
        sendUserPassword(currentPassword: "123456", newPassword: "Password")
    }
    
    func sendUserInfo(userName: String, firstName: String, lastName: String) {
        
        let urlString = "https://api.foo.com/profiles/update"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        let user = User(userName: userName, firstName: firstName, lastName: lastName, currentPassowrd: nil, newPassword: nil)
        
        do {
            
            let jsonData = try encoder.encode(user)
            
            request.httpBody = jsonData
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                return
                
            } else {
                
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,AnyObject>
                    
                    for (key, value) in parsedData {
                        
                        if key == "message" {
                            
                            if let message = (value as? String) {
                                
                                print(message)
                                //Do something with message.
                            }
                        }
                        
                        if key == "data" {
                            
                            if let jsonData = (value as? String) {
                                
                                let userData = Data(jsonData.utf8)
                                
                                do {
                                    
                                    let decoder = JSONDecoder()
                                    _ = try decoder.decode(User.self, from: userData)
                                    //Do something with User data.
                                    
                                } catch let error as NSError {
                                    
                                    print(error.localizedDescription)
                                    return
                                }
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        task.resume()
        
    }
    
    func sendUserPassword(currentPassword: String, newPassword: String) {
        
        let urlString = "https://api.foo.com/password/change"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        let user = User(userName: nil, firstName: nil, lastName: nil, currentPassowrd: currentPassword, newPassword: newPassword)
        
        do {
            
            let jsonData = try encoder.encode(user)
            
            request.httpBody = jsonData
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                return
                
            } else {
                
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,AnyObject>
                    
                    for (key, value) in parsedData {
                        
                        if key == "code" {
                            
                            if let code = (value as? String) {
                                
                                print(code)
                            }
                            
                        } else if key == "message" {
                            
                            if let message = (value as? String) {
                                
                                print(message)
                            }
                            
                        } else if key == "exceptionName" {
                            
                            if let exceptionName = (value as? String) {
                                
                                print(exceptionName)
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        task.resume()
        
    }
}

