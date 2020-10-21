//
//  CollectionItem.swift
//  booksApp
//
//  Created by оля on 05.10.2020.
//  Copyright © 2020 Olya. All rights reserved.
//

import Foundation

class CollectionItem: Hashable {
    
    let imageName: String
    let title: String?
    let author: String?
    
    init(imageName: String, title: String? = nil, author: String? = nil) {
        self.imageName = imageName
        self.title = title
        self.author = author
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CollectionItem, rhs: CollectionItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
