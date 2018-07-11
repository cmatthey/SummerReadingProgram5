//
//  SearchBooksDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 7/11/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class SearchBooksDataService {
    let userDefaults = UserDefaults.standard
    
    func searchByISBN(isbn: String, completion: @escaping (String, String) -> Void) {
        let googlebooksapikey = KeychainWrapper.standard.string(forKey: "googlebooksapikey")
        let searchByISBNUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(googlebooksapikey!)"
        Alamofire.request(searchByISBNUrl, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Response String: \(String(describing: response.result.value))")
                    if let value = response.result.value {
                        if let totalItems = JSON(value)["totalItems"].int,  totalItems > 0 {
                            if let title = JSON(value)["items"][0]["volumeInfo"]["title"].string,
                                let author = JSON(value)["items"][0]["volumeInfo"]["authors"][0].string {
                                completion(title, author)
                            }
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
