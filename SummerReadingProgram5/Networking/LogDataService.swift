//
//  LogDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire

///
/// Networking service to handle get reading log summary and create a new reading log entry
///
class LogDataService {
//    var readerId: Int
    var allLogUrl: String = ""
    
    func getLogs(readerId: Int, completion: @escaping ([Log]?) -> Void) {
//        allLogUrl = "http://localhost:8000/api/v1/reader/\(readerId)/log/"
        allLogUrl = "http://35.238.0.108/booklogs/api/v1/reader/\(readerId)/log/"
        
        Alamofire.request(allLogUrl, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: String(data: response.data!, encoding: .utf8)))")
                    if let data = response.data {
                        do {
                            let logs = try JSONDecoder().decode([Log].self, from: data)
                            completion(logs)
                        } catch {
                            print("Unexpected json response: \(error).")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Error response: \(utf8Text)")
                    }
                    completion(nil)
                }
        }
    }
    
    func createLog(readerId: Int, title: String, author: String) {
//        allLogUrl = "http://localhost:8000/api/v1/reader/\(readerId)/log/"
        allLogUrl = "http://35.238.0.108/booklogs/api/v1/reader/\(readerId)/log/"
        let payload: [String: Any] = [
            "readerId": readerId,
            "title": title,
            "author": author
        ]
        
        Alamofire.request(allLogUrl, method: .post, parameters: payload, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: String(data: response.data!, encoding: .utf8)))")
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Error response: \(utf8Text)")
                    }
                }
        }
    }
}
