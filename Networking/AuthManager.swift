//
//  AuthService.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation
import Combine

enum ServiceError: Error {
    case serverError(String)
    case unkown(String = "An unknown error occured.")
    case decodingError(String = "Error parsing server response.")
}


class AuthManager {
    
    
    static var shared = AuthManager()
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        UserDefaults.standard.set(false, forKey: "isTokenValid")
    }
    
    private var currentToken: String?
    = String(data: KeychainHelper.standard.read(service: Constants.service, account: Constants.account)!, encoding: .utf8) ?? nil
    
   private let queue = DispatchQueue(label: "Autenticator.\(UUID().uuidString)")

  // this publisher is shared amongst all calls that request a token refresh
   private var refreshPublisher: AnyPublisher<Data, Error>?
    
    func publisher(request: URLRequest, token: String?) -> AnyPublisher<Data, Error> {
        var request = request
        if let token = token {
            request.addToken(with: token)
        }
//        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://tapcash.000webhostapp.com/api/tapcash/orange/v1/register")!)
        
//        return self.validToken()
//            .tryMap({ token in
//                let userToken = try JSONDecoder().decode(String, from: token)
//
//            // we can now use this token to authenticate the request
//              URLSession.shared.dataTaskPublisher(for: request)
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
        return URLSession.shared.dataTaskPublisher(for: request)
         
        // tryMap offers a way to process the response with a closure that can throw an error
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw ServiceError.decodingError()
                }
                if httpResponse.statusCode == 406 {
                    
                } else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
                .eraseToAnyPublisher()
        // type erase the publisher so that its easy to handle the response in the sink subscriber
    }
    
      
      func validToken(forceRefresh: Bool = false) -> AnyPublisher<Data, Error> {
          
        return queue.sync { [weak self] in
          // scenario 1: we're already loading a new token
          if let publisher = self?.refreshPublisher {
              return publisher
          }

          // scenario 2: we don't have a token at all, the user should probably log in
          guard let token = self?.currentToken else {
            return Fail(error: AuthenticationError.loginRequired)
              .eraseToAnyPublisher()
          }

          // scenario 3: we already have a valid token and don't want to force a refresh
            if UserDefaults.standard.bool(forKey: "isTokenValid") , !forceRefresh {
                
            return Just(KeychainHelper.standard.read(service: Constants.service, account: Constants.account)!)
              .setFailureType(to: Error.self)
              .eraseToAnyPublisher()
          }

          // scenario 4: we need a new token
            guard let request = Endpoint.refresh().request else {
                return Fail(error: "request has failed" as! Error)
                      .eraseToAnyPublisher() }
            let publisher = publisher(request: request, token: token)
            .share()
            .handleEvents(receiveOutput: { response in
            do {
                let userResponse = try JSONDecoder().decode(Response.self, from: response)
                self?.currentToken = userResponse.authorisation.token
                let data = Data(userResponse.authorisation.token.utf8)
                KeychainHelper.standard.save(data,service: Constants.service, account: Constants.account)
                
                } catch {
                    assertionFailure("Fail to decode response: \(error)")
                    }
                
            }, receiveCompletion: { _ in
              self?.queue.sync {
                self?.refreshPublisher = nil
              }
            })
            .eraseToAnyPublisher()
            
            self?.refreshPublisher = publisher
            return publisher
        }
      }
      
}
      enum AuthenticationError: Error {
        case loginRequired
      }
//
//func performAuthenticatedRequest() -> AnyPublisher<Response, Error> {
//  let url = URL(string: "https://donnys-app.com/authenticated/resource")!
//
//  return authenticator.validToken()
//    .flatMap({ token in
//      // we can now use this token to authenticate the request
//      session.publisher(for: url, token: token)
//    })
//    .tryCatch({ error -> AnyPublisher<Data, Error> in
//      guard let serviceError = error as? ServiceError,
//            serviceError.errors.contains(ServiceErrorMessage.invalidToken) else {
//        throw error
//      }
//
//      return authenticator.validToken(forceRefresh: true)
//        .flatMap({ token in
//          // we can now use this new token to authenticate the second attempt at making this request
//          session.publisher(for: url, token: token)
//        })
//        .eraseToAnyPublisher()
//    })
//    .decode(type: Response.self, decoder: JSONDecoder())
//    .eraseToAnyPublisher()
//}
