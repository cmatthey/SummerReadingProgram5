//
//  Reader.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/29/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation

///
/// Class that represents a reader
///
class Reader: NSObject, NSCoding, Codable {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(readerId, forKey: "readerId")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(photoPath, forKey: "photoPath")
        aCoder.encode(goal, forKey: "goal")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.readerId = aDecoder.decodeInteger(forKey: "readerId")
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.photoPath = aDecoder.decodeObject(forKey: "photoPath") as! String
        self.goal = aDecoder.decodeInteger(forKey: "goal")
    }
    
    var readerId: Int
    var email: String
    var name: String
    var photoPath: String
    var goal: Int
    
    init?(readerId: Int, email: String, name: String, photoPath: String, goal: Int) {
        self.readerId = readerId
        self.email = email
        self.name = name
        self.photoPath = photoPath
        self.goal = goal
    }
}
