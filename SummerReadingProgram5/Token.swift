//
//  Token.swift
//  SummerReadingProgram5
//
//  Created by Coco Matthey on 6/30/18.
//  Copyright © 2018 Coco Matthey. All rights reserved.
//

import Foundation

struct Token: Decodable {
    var token: String
    
    init(token: String) {
        self.token = token
    }
}
