//
//  AuthService.swift
//  TabCash
//
//  Created by KH on 07/05/2023.
//

import Foundation
import Combine



class AuthManager {
    
    static var shared = AuthManager()
    
    
    func fetch(path: String, parameters: [[String: Any]], completion: @escaping (Result<Response, Error>) -> Void) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
            if param["disabled"] != nil { continue }
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
                body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
                let paramValue = param["value"] as! String
                body += "\r\n\r\n\(paramValue)\r\n"
            } else {
                let paramSrc = param["src"] as! String
                let fileData = try? NSData(contentsOfFile: paramSrc, options: []) as Data
                let fileContent = String(data: fileData!, encoding: .utf8)!
                body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Constants.fullURL + path)!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            do {
                let results = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(results))
            } catch {
//                if let res = data.result.value {
                let response = data as! NSDictionary
                                   let message = response.object(forKey: "message")!
                                   print(message)
                completion(.failure(ServiceError.decodingError(message as! String)))
            }
        }
        
        task.resume()
    }
    
    
    
    func logout(path: String = "/logout", completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: URL(string: Constants.fullURL + path)!,timeoutInterval: Double.infinity)
        
        if let token = AuthenticationViewViewModel.auth.token {
            request.addValue("Bearer" + token, forHTTPHeaderField: "Authorization")
        } else {
            return
        }
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                if let error = error {
                    completion(.failure(ServiceError.serverError("server errror " + error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unkown()))
                }
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            do {
                completion(.success(str))
            } catch {
                completion(.failure(ServiceError.decodingError("decoding error " + str)))
            }
        }
        
        task.resume()
        
    }
    
}
//
//    func fetch(request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data else {
//                if let error = error {
//                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
//                } else {
//                    completion(.failure(ServiceError.unkown()))
//                }
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            if let successMessage =  try? decoder.decode(SucessResponse.self, from: data) {
//                completion(.success(successMessage.success))
//                return
//            }
//            else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: data) {
//                completion(.failure(ServiceError.serverError(errorMessage.error)))
//                return
//            }
//            else {
//                completion(.failure(ServiceError.decodingError()))
//                return
//            }
//        }.resume()
//    }
//
//        // MARK: - Sign Out
//        static func signOut() {
//            let url = URL(string: Constants.fullURL)!
////            let cookie = HTTPCookieStorage.shared.cookies(for: url)!.first!
//            HTTPCookieStorage.shared.deleteCookie(cookie)
//        }


//
//    if httpResponse.statusCode == 406 {
//
//    }
//        return URLSession.shared.dataTaskPublisher(for: request)
//
//        // tryMap offers a way to process the response with a closure that can throw an error
//            .tryMap() { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse else {
//                    throw ServiceError.decodingError()
//                }
//               else {
//                        throw URLError(.badServerResponse)
//                    }
//                return element.data
//                }
//                .eraseToAnyPublisher()
//        // type erase the publisher so that its easy to handle the response in the sink subscriber
//    }
//
//
//
