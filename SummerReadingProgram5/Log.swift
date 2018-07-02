//
//  Log.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation

class Log: Codable {
    var logId: Int64
    var readerId: Int64
    var author: String
    var title: String
    var note: String
    
    init(logId: Int64, readerId: Int64, title: String, author: String, note: String) {
        self.logId = logId
        self.readerId = readerId
        self.title = title
        self.author = author
        self.note = note
    }
}
