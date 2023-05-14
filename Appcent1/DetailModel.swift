//
//  DetailModel.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import Foundation

struct Song: Codable {
    
    let id: Int
    let title: String
    let duration: Int
    let preview: String
    let cover: String
    
    init(id: Int, title: String, duration:Int, preview:String, cover: String) {
        self.id = id
        self.title = title
        self.duration = duration
        self.preview = preview
        self.cover = cover
    }
}
