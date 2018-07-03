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
    var registrationUrl = "http://35.238.0.108:8000/api/v1/rest-auth/registration/"
    var createReaderUrl = "http://35.238.0.108:8000/api/v1/reader/"
    let userDefaults = UserDefaults.standard
    
    func registration(username: String, password1: String, password2: String, completion: @escaping (String, Int) -> Void) {
        let payload = [
            "username": username,
            "password1": password1,
            "password2": password2,
        ]
        
        Alamofire.request(registrationUrl, method: .post, parameters: payload)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let value = response.result.value {
                        if let token = JSON(value)["key"].string {
                            self.userDefaults.set(true, forKey: "loggedIn")
                            self.userDefaults.set(token, forKey: "token")
                            self.createUser(name: username, appleId: "", completion: { reader in
                                print("reader: \(reader)")
                                
                                self.userDefaults.set(reader.readerId, forKey: "readerId")
                                self.userDefaults.set(reader.goal, forKey: "goal")
                                
                                completion(token, reader.readerId)

                                do {
                                    let fm = FileManager.default
                                    let url = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                    let path = url.appendingPathComponent("reader")
                                    print("path: \(path.absoluteString).")
                                    NSKeyedArchiver.archiveRootObject(reader, toFile: path.absoluteString)
                                    
                                    // start testing
                                    if let reader2 = NSKeyedUnarchiver.unarchiveObject(withFile: path.absoluteString) as? Reader {
                                        print("reader in create service: \(reader2).")
                                    } else {
                                        print("NSKeyedUnarchiver failure")
                                    }
                                    // end testing
                                } catch {
                                    print("DocumentDirectory error: \(error).")
                                }
                            })
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

