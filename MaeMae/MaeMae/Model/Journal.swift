//
//  Journal.swift
//  MaeMae
//
//  Created by Woowon Kang on 4/17/24.
//

import Foundation
import SwiftData

@Model
class Journal {
    var creationDate: Date = Date.now
    var title: String
    var category: String?
    var contents: String
    
    
    init(title: String, category: String? = nil, contents: String) {
        self.title = title
        self.category = category
        self.contents = contents
    }
    
    var stock: Stock?
}
