//
//  List.swift
//  Notes
//
//  Created by Artem Karmaz on 2/4/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

class Lists {
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
