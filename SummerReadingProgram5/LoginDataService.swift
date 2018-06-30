//
//  LoginDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire

class LoginReaderDataService {
    // In order for plain text http work, App Transport Security Settings -> Allow Arbitrary Loads need to be YES in info.plist.
    var createReaderUrl = "http://localhost:8000/api/v1/rest-auth/login/"
    
    func login(username: String, password: String) {
        let payload = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(createReaderUrl, method: .post, parameters: payload, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let data = response.data {
                        // TODO: Where to store the user state, use default?
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    // TODO: is this right?
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)")
                    }
                }
        }
    }
}
