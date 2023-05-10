//
//  SignupUserRequest.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

struct SignupUserRequest: Codable {
    let email: String
    let name: String
    let password: String
    let phone: String
}
