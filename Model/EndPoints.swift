//
//  EndPoints.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation
import Combine

enum Endpoint {
    
    case createAccount(path: String = "/register", userRequest: SignupUserRequest)
    case signIn(path: String = "/login", userRequest: LoginUserRequest)
    case forgotPassword(path: String = "/forgot-password", email: String)
    case logout(path: String = "/logout")
    case refresh (path: String = "/refresh")
    case getBalance(path: String = "/balance")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        URL(string: "\(Constants.fullURL + self.path)")
    }
    
    private var path: String {
        switch self {
        case .createAccount(let path, _),
                .signIn(let path, _),
                .forgotPassword(let path, _),
                .logout(let path),
                .getBalance(let path),
                .refresh(let path):
            return path
        }
    }
    private var httpMethod: String {
        switch self {
        case .createAccount,
                .signIn,
                .forgotPassword,
                .logout,
                .refresh:
            return HTTP.Method.post.rawValue
        case .getBalance:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .createAccount(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
            
        case .signIn(_, let userRequest):
            return try? JSONEncoder().encode(userRequest)
            
        case .forgotPassword(_, let email):
            return try? JSONSerialization.data(withJSONObject: ["email": email], options: [])
      
        case .getBalance,
             .logout,
             .refresh:
            return nil
        }
    }
    
}


extension URLRequest {
    
//    func performAuthenticatedRequest(url: String) -> AnyPublisher<Response, Error> {
//      let url = URL(string: "https://donnys-app.com/authenticated/resource")!
//
//      return authenticator.validToken()
//        .flatMap({ token in
//          // we can now use this token to authenticate the request
//            AuthManager.shared.publisher(for: url, token: token)
//        })
//        .tryCatch({ error -> AnyPublisher<Data, Error> in
//          guard let serviceError = error as? ServiceError,
//                serviceError.errors.contains(ServiceErrorMessage.invalidToken) else {
//            throw error
//          }
//
//          return authenticator.validToken(forceRefresh: true)
//            .flatMap({ token in
//              // we can now use this new token to authenticate the second attempt at making this request
//              session.publisher(for: url, token: token)
//            })
//            .eraseToAnyPublisher()
//        })
//        .decode(type: Response.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
//    }
        
    mutating func addToken(with token: String){
        
//        return .validToken()
//          .flatMap({ token in
//            // we can now use this token to authenticate the request
//            session.publisher(for: url, token: token)
//          })
//          .tryCatch({ error -> AnyPublisher<Data, Error> in
//            guard let serviceError = error as? ServiceError,
//                  serviceError.errors.contains(ServiceErrorMessage.invalidToken) else {
//              throw error
//            }
//
//            return authenticator.validToken(forceRefresh: true)
//              .flatMap({ token in
//                // we can now use this new token to authenticate the second attempt at making this request
//                session.publisher(for: url, token: token)
//              })
//              .eraseToAnyPublisher()
//          })
//          .decode(type: Response.self, decoder: JSONDecoder())
//          .eraseToAnyPublisher()
//
       self.setValue(HTTP.Headers.Value.Bearer.rawValue + token, forHTTPHeaderField: HTTP.Headers.Key.Authorization.rawValue)
    }
}
