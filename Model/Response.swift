//
//  LoginResPonse.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation


// MARK: - ServiceError

enum ServiceError: Error {
    case serverError(String)
    case unkown(String = "An unknown error occured.")
    case decodingError(String = "Error parsing server response.")
    case invalidToken(String = "Token Expired")
}

// MARK: - TokenInvalidMessage
struct TokenInvalidMessage: Codable {
    let status: Int
    let message: String
}


// MARK: - TransferResponse
struct TransferResponse: Codable {
    let status: Int
    let message: String
    let data: DataTransferClass
}

// MARK: - DataTransferClass
struct DataTransferClass: Codable {
    let amount, balanceBefore, blanceAfter: String
}


// MARK: - BalanceResponse
struct BalanceResponse: Codable {
    let status: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let balance: String
}


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


