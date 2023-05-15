import Foundation

// This is a struct representing a category object with its properties.
// It conforms to the Codable protocol to support encoding and decoding from/to JSON.
struct Album: Codable{
    
    let id: Int
    let title: String
    let cover: String
    let release_date: String
}
