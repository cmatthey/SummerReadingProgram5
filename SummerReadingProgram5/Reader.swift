//
//  Reader.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation

struct Reader: Decodable {
    var readerId: Int64
    var email: String
    var name: String
    var photoPath: String
    var goal: Int64
    
    init(readerId: Int64, email: String, name: String, photoPath: String, goal: Int64) {
        self.readerId = readerId
        self.email = email
        self.name = name
        self.photoPath = photoPath
        self.goal = goal
    }
}
