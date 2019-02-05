//
//  List.swift
//  Notes
//
//  Created by Artem Karmaz on 2/4/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

class List {
    var category: String = "Notes"
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(category: String, name: String) {
        self.category = category
        self.name = name
    }
}

class Note {
    var contents: String
    let timestamp: Date
    
    // an automatically generated note title, based on the first line of the note
    var title: String {
        // split into lines
        let lines = contents.components(separatedBy: CharacterSet.newlines)
        // return the first
        return lines[0]
    }
    
    init(text: String) {
        contents = text
        timestamp = Date()
    }
    
}
