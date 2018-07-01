//
//  CreateReaderDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateReaderDataService {
    // In order for plain text http work, App Transport Security Settings -> Allow Arbitrary Loads need to be YES in info.plist.
    var registrationUrl = "http://localhost:8000/api/v1/rest-auth/registration/"
    var createReaderUrl = "http://localhost:8000/api/v1/reader/"
    let userDefaults = UserDefaults.standard
    
    func createUser(username: String, password1: String, password2: String, completion: @escaping (String) -> Void) {
        // TODO: How to return reader inside closure
//        var reader: Reader = Reader(readerId: 1, email: "noreply@gmail.com", name: "Coco", photoPath: "", goal: 5)
        let payload = [
//            "email": email,
            "username": username,
            "password1": password1,
            "password2": password2,
//            "appleId": email,
        ]
        
        // Alamofire https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#parameter-encoding
        Alamofire.request(registrationUrl, method: .post, parameters: payload, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let value = response.result.value {
                        if let token = JSON(value)["key"].string {
                            self.userDefaults.set(true, forKey: "isLoggedIn")
                            completion(token)
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Error response: \(utf8Text)")
                    }
                }
        }
    }
}
