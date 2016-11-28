//
//  Word.swift
//  Frankentable
//
//  Created by Tom Seymour on 11/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Word: NSObject {
    let name: String
    let count: Int
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}
