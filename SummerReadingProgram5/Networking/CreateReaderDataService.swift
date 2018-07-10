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

///
/// Networking service to handle registration and create a user in the reader table
///
class CreateReaderDataService {
//    var registrationUrl = "http://localhost:8000/api/v1/rest-auth/registration/"
//    var createReaderUrl = "http://localhost:8000/api/v1/reader/"
    var createReaderUrl = "http://35.238.0.108:8000/api/v1/reader/"
    let userDefaults = UserDefaults.standard
    
    func createUser(name: String, appleId: String, completion: @escaping (Reader) -> Void) {
        let payload = [
            "name": name,
            "appleId": appleId
        ]
        
        Alamofire.request(createReaderUrl, method: .post, parameters: payload)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let data = response.data {
                        do {
                            let reader = try JSONDecoder().decode(Reader.self, from: data)
                            completion(reader)
                        } catch {
                            print("Unexpected json response: \(error).")
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

