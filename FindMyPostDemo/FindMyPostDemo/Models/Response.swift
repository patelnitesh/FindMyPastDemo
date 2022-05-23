//
//  Response.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let success: Bool?
    let data: [Person]?
}

// MARK: - Person
struct Person: Codable {
    let id, firstname, surname, dob: String?
    let image: String?
    let relationships: Relationships?
}


// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let success: Bool?
    let data: Person?
}

// MARK: - Relationships
struct Relationships: Codable {
    let spouse, mother, father: String?
    let children: [String]?
}

extension Person {
    
    var fullName: String {
        [firstname ?? "No First name", surname ?? "No Surname"].joined(separator: " ")
    }
    
    var dateOfBirth: String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "ddMMyyyy"
        
        guard let dob = dob, let date = dateFormatter.date(from: dob) else {
            return ""
        }
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    var imageURL: String? {
        image
    }
    
    static func dummyPerson() -> Person {
        Person(id: "001",
               firstname: "FNAME",
               surname: "SNAME",
               dob: "01011900",
               image: nil,
               relationships: Relationships.dummyRelationship())
    }
}

extension Relationships {
    static func dummyRelationship() -> Relationships {
        Relationships(spouse: "002",
                      mother: "003",
                      father: "004",
                      children: ["005","006"])
    }
}
