//
//  Note.swift
//  collectNotes
//
//  Created by MD Faizan on 29/01/23.
//

import Foundation

// Codable is a type alias for the Encodable and Decodable protocols
struct Note:Codable {
    
    var title: String
    var description: String
    var id: String
    var trash: Bool
    var archive: Bool
    
    //    var dictionary: [String: Any] {
    //        return [
    //            "title": title,
    //            "description": description
    //        ]
    //    }
}




