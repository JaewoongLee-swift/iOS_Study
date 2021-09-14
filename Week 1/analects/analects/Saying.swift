//
//  Saying.swift
//  analects
//
//  Created by 이재웅 on 2021/08/14.
//

import Foundation

class Saying {
    var sayings: [String: String]
    var authors: [String]
    
    init(authors: [String], sayings: [String: String]) {
        self.authors = authors
        self.sayings = sayings
        self.authors.shuffle()
    }
}
