//
//  LoginDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper


///
/// Networking service to handle login
///
class LoginReaderDataService {
//    var createReaderUrl = "http://localhost:8000/api/v1/rest-auth/login/"
    var loginUrl = "http://35.238.0.108/booklogs/api/v1/rest-auth/login/"
    let userDefaults = UserDefaults.standard
    
    func login(username: String, password: String, completion: @escaping (String) -> Void ) {
        let payload = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(loginUrl, method: .post, parameters: payload)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let value = response.result.value {
                        if let token = JSON(value)["key"].string {
                            self.userDefaults.set(true, forKey: "loggedIn")
                            KeychainWrapper.standard.set(token, forKey: "token")
                            completion(token)
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Error response: \(utf8Text)")
                    }
                    completion("Login failed")
                }
        }
    }
}
