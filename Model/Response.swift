//
//  LoginResPonse.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let status: String
    let user: User
    let authorisation: Authorisation
}

// MARK: - Authorisation
struct Authorisation: Codable {
    let token, type: String
}

// MARK: - User
struct User: Codable {
    let name, email: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case name, email
        case phone
    }
}


