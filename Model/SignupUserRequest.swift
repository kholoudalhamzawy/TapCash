//
//  SignupUserRequest.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

struct SignupUserRequest {
    let email: String
    let name: String
    let password: String
    let phone: String
    lazy var parameters = [
      [
        "key": "name",
        "value": name,
        "type": "text"
      ],
      [
        "key": "email",
        "value": email,
        "type": "text"
      ],
      [
        "key": "password",
        "value": password,
        "type": "text"
      ],
      [
        "key": "phone",
        "value": phone,
        "type": "text"
      ]] as [[String: Any]]
}
