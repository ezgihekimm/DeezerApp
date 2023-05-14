//
//  CategoryModel.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import Foundation

struct Category: Codable{
    
    let id: Int
    let name: String
    let picture: String
    
    init(id: Int, name: String, picture: String) {
        self.id = id
        self.name = name
        self.picture = picture
    }
    
}
