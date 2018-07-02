//
//  Token.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/30/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation

class Token: Codable {
    var token: String
    
    init(token: String) {
        self.token = token
    }
}
