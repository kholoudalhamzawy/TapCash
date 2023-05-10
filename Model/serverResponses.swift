//
//  ServiceError.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

struct SucessResponse: Decodable {
    let success: String
}

struct ErrorResponse: Decodable {
    let error: String
}
