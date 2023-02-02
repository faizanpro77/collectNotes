//
//  Note.swift
//  collectNotes
//
//  Created by MD Faizan on 29/01/23.
//

import Foundation

struct Note:Codable {
    
    var title: String
    var description: String
    var id: String
    
//    var dictionary: [String: Any] {
//        return [
//            "title": title,
//            "description": description
//        ]
//    }
}

/**
 *Any*
 Any can represent an instance of any type at all, including function types.
 * Swift provides  special type for working with nonspecific type
 

 
 var things: [Any] = []

 things.append(0)
 things.append(0.0)
 things.append(42)
 things.append(3.14159)
 things.append("hello")
 
 Typealias

*A type alias allows you to provide a new name for an existing data type into your program. After a type alias is declared, the aliased name can be used instead of the existing type throughout the program.

 example
 var message: String?
 typealias Message = String
 var message: Message?
 var customerMessage: Message
 ===================================
 **Codable
 Codable is a type alias for the Encodable and Decodable protocols
 
 
** These two protocols are used to indicate whether a certain struct, enum, or class, can be encoded into JSON data, or materialized from JSON data.
 
 typealias Codable = Decodable & Encodable
 
 Decodable (or Deserialization)
 An object that conforms Decodable protocol can be converted from JSON to object.

 let student = try? JSONDecoder().decode(Student.self, from: jsonData)

 Encodable (or Serialization)
 An object that conforms Encodable protocol can be converted to JSON. Ex:

 let jsonData = try? JSONEncoder().encode(student)
 
 if you want to do both you can conform to Codable.


 */
