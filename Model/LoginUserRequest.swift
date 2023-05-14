//
//  LoginUserRequest.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

struct LoginUserRequest {
    let email: String
    let password: String
    lazy var parameters = [
      [
        "key": "email",
        "value": email,
        "type": "text"
      ],
      [
        "key": "password",
        "value": password,
        "type": "text"
      ]] as [[String: Any]]
}
