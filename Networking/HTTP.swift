//
//  HTTP.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {

        enum Key: String {
            case contentType = "Content-Type"
            case Authorization = "Authorization"
        }

        enum Value: String {
            case applicationJson = "application/json"
            case Bearer = "Bearer "
        }
        
    }
}

extension UserDefaults {
    @objc dynamic var Token: String {
        return string(forKey: "Token") ?? ""
    }
}
