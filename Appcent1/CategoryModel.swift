import Foundation

// This is a struct representing a category object with its properties.
// It conforms to the Codable protocol to support encoding and decoding from/to JSON.
struct Category: Codable{

    let id: Int
    let name: String
    let picture: String
}
