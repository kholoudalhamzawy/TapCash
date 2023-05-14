//
//  AuthenticationViewViewModel.swift
//  TabCash
//
//  Created by KH on 01/05/2023.
//

import Foundation
import Combine
import UIKit


final class AuthenticationViewViewModel: ObservableObject {
    
    static let auth = AuthenticationViewViewModel()

    @Published var email: String?
    @Published var password: String?
    @Published var phoneNumber: String?
    @Published var confirmPassword: String?
    @Published var name: String?
    @Published var user: User?
    @Published var token: String?
    @Published var balance: String?
    @Published var idImage: UIImage?
    @Published var hasAccessToken: Bool = false
    @Published var isAuthenticationFormValid: Bool = false
    @Published var subscriptions: Set<AnyCancellable> = []
    @Published var error: String?
    @Published var emailError: String?
    @Published var nameError: String?
    @Published var passwordError: String?
    @Published var phoneError: String?
    @Published var passwordConfirmError: String?


    func invalidnameMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        } else if text.count < 2 {
            return "* name must be atleast 2 digits *"
        }
        return ""

    }

    func invalidEmailMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        } else if let _ = EmailAddress(rawValue: text){
            return ""
        } else {
            return "* invaled email adress *"
        }
    }

    func invalidPhoneMessage(_ text: String) -> String{
        let set = CharacterSet(charactersIn: text)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "* phone number must only contain digits *"
        } else if text.isEmpty  {
            return "* this Field is required *"
        } else if text.count != 11 {
            return "* phone number must be 11 Digits *"
        } else {
            return ""
        }
    }


    func invalidPasswordMessage(_ text: String) -> String{
        if text.isEmpty {
            return "* this Field is required *"
        } else if text.count < 8 {
            return "* password must be atleast 8 digits *"
        } else if !containsDigit(text){
            return "* password must contain at least 1 digit *"
        } else if !containsLowerCase(text){
            return "* password must contain at least 1 lowercase *"
        } else if !containsUpperCase(text){
            return "* password must contain at least 1 uppercase *"
        } else {
            return ""
        }

    }
    
    func invalidConfirmPasswordMessage(_ text: String, _ confirmText: String) -> String{
        if confirmText.isEmpty {
            return "* this Field is required *"
        } else if text != confirmText {
            return "* password doesn't match "
        } else {
            return ""
        }

    }
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    


    func validateAuthenticationLogInForm(){
        guard let email = email, let password = password else {
            isAuthenticationFormValid = false
            return
        }

        passwordError = invalidPasswordMessage(password)
        emailError = invalidEmailMessage(email)
        isAuthenticationFormValid = passwordError!.isEmpty &&
                                    emailError!.isEmpty

    }

    func validateAuthenticationsignUpForm(){
        guard let email = email,
              let password = password,
              let confirmPassword = confirmPassword,
              let phoneNum = phoneNumber,
              let name = name else {
            isAuthenticationFormValid = false
            return
        }
        passwordError = invalidPasswordMessage(password)
        emailError = invalidEmailMessage(email)
        nameError = invalidnameMessage(name)
        phoneError = invalidPhoneMessage(phoneNum)
        passwordConfirmError = invalidConfirmPasswordMessage(password, confirmPassword)
        isAuthenticationFormValid = passwordError!.isEmpty &&
                                    emailError!.isEmpty    &&
                                    nameError!.isEmpty     &&
                                    phoneError!.isEmpty    &&
                                    passwordConfirmError!.isEmpty
    }

    func createUser() {
        guard let email = email,
              let password = password,
              let phone = phoneNumber,
              let name = name
        else {return}
        
        var userRequest = SignupUserRequest(email: email, name: name, password: password, phone: phone)
                                 
        AuthManager.shared.fetch(path: "/register", parameters: userRequest.parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.user = response.user
                    AuthenticationViewViewModel.auth.token = response.authorisation.token
                    let token = Data( response.authorisation.token.utf8)
                    KeychainHelper.standard.save(token, service: Constants.service, account: Constants.account)

                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                        print(string)
                        self?.error = string
                    }
                }
            }
        }
    }
    
    func logInUser() {
           guard let email = email, let password = password else {
               return
           }
              var userRequest = LoginUserRequest(email: email, password: password)
   
   
        AuthManager.shared.fetch(path: "/login", parameters: userRequest.parameters) { [weak self] result in
        DispatchQueue.main.async {
            
//                [weak self] in
//                guard let self = self else { return }
            switch result {
            case .success(let response):
                self?.user = response.user
                AuthenticationViewViewModel.auth.token = response.authorisation.token
                let token = Data( response.authorisation.token.utf8)
                KeychainHelper.standard.save(token, service: Constants.service, account: Constants.account)
                print(response)

            case .failure(let error):
                
                guard let error = error as? ServiceError else { return }
                
                switch error {
                case .serverError(let string),
                        .unkown(let string),
                        .decodingError(let string):
                    self?.error = string
                    print(string)
//                        AlertManager.showSignInErrorAlert(on: self, with: string)
                }
            }
        }
    }
    
}
    func logoutUser() {
        AuthManager.shared.logout() { [weak self] result in
        DispatchQueue.main.async {
            
            switch result {
            case .success(let response):
                self?.user = nil
                AuthenticationViewViewModel.auth.token = nil
                KeychainHelper.standard.delete(service: Constants.service, account: Constants.account)
                print(response)

            case .failure(let error):
                guard let error = error as? ServiceError else { return }
                switch error {
                case .serverError(let string),
                        .unkown(let string),
                        .decodingError(let string):
                    self?.error = string
                    print(string)
                }
            }
        }
    }
    
}
}
