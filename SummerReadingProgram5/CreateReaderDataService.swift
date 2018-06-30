//
//  CreateReaderDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire

class CreateReaderDataService {
    // In order for plain text http work, App Transport Security Settings -> Allow Arbitrary Loads need to be YES in info.plist.
    var createReaderUrl = "http://localhost:8000/api/v1/reader/"
    
    func createUser(email: String, password: String) {
        // TODO: How to return reader inside closure
//        var reader: Reader = Reader(readerId: 1, email: "noreply@gmail.com", name: "Coco", photoPath: "", goal: 5)
        let payload = [
            "email": email,
            "password": password,
            "appleId": email,
            "name": email
        ]
        
        // Alamofire https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#parameter-encoding
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
