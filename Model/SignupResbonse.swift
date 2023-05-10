//
//  SignupResbonse.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

// MARK: - SignupResbonse
struct SignupResbonse: Codable {
    let status, message: String
    let user: User
    let authorisation: Authorisation
}

// MARK: - Authorisation
struct Authorisation: Codable {
    let token, type: String
}

// MARK: - User
struct User: Codable {
    let name, email, phone: String
}
