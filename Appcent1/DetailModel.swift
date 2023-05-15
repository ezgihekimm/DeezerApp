// This is a struct representing a category object with its properties.
// It conforms to the Codable protocol to support encoding and decoding from/to JSON.
import Foundation

struct Song: Codable {
    
    let id: Int
    let title: String
    let duration: Int
    let preview: String
    let cover: String
}
