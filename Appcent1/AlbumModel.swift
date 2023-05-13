//
//  AlbumModel.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import Foundation

struct Album: Codable{
    
    let id: Int
    let title: String
    let cover: String
    let release_date: String
    
    init(id: Int, title: String, cover: String, release_date: String) {
        self.id = id
        self.title = title
        self.cover = cover
        self.release_date = release_date
    }
}
