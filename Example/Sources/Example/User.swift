//
//  File.swift
//  
//
//  Created by Artem Bobrov on 08.02.2021.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let dateString: String
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        struct Geo: Codable {
            let lat: String
            let lng: String
        }
        let geo: Geo
    }
    let address: Address
    let phone: String
    let website: String
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
    let company: Company
}

extension User {
    static func loadTestUser() -> User {
        let decoder = JSONDecoder()

        let userData = try! Data(contentsOf: Bundle.module.url(forResource: "user", withExtension: "json")!)
        return try! decoder.decode(User.self, from: userData)
    }
}
