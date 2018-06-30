//
//  ReaderDataService.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation
import Alamofire

class ReaderDataService {
    let readerId: Int64
    var readerUrl: String
    
    init(readerId: Int64) {
        self.readerId = readerId
        self.readerUrl = "http://localhost:8000/api/v1/reader/\(readerId)/"
    }
}
