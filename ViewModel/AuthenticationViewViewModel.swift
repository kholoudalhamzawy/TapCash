//
//  AuthenticationViewViewModel.swift
//  TabCash
//
//  Created by KH on 01/05/2023.
//

import Foundation
import Combine



final class AuthenticationViewViewModel: ObservableObject {

    @Published var email: String?
    @Published var password: String?
    @Published var phoneNumber: String?
    @Published var confirmPassword: String?
    @Published var name: String?
    @Published var user: User?
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
        
        let userRequest = SignupUserRequest(email: email, name: name, password: password, phone: phone)
        
        guard let request = Endpoint.createAccount(userRequest: userRequest).request else { return }
        
//        var request = URLRequest(url: URL(string:"https://tapcash.000webhostapp.com/api/tapcash/orange/v1/register")!)
                                 
        AuthManager.shared.publisher(request: request, token: nil)
            .decode(type: Response.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { response in
                let data = Data(response.authorisation.token.utf8)
                KeychainHelper.standard.save(data,service: Constants.service, account: Constants.account)
                print("response")
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion { //the completion that's returned either is failure or success, so instead of switch statement we just put " if case .failure " because we only want to check for that case
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                            self?.error = string
                        self?.error = error.localizedDescription
                    }
                }

            } receiveValue: {  response in
                UserDefaults.standard.set(response.user.name, forKey: "username")
            }
            .store(in: &subscriptions)
    }

    

    func logInUser() {
        guard let email = email, let password = password else {
            return
        }
        
        let userRequest = LoginUserRequest(email: email, password: password)
        
        guard let request = Endpoint.signIn(userRequest: userRequest).request else { return }
                                 
        AuthManager.shared.publisher(request: request, token: nil)
            .decode(type: Response.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { response in
                let data = Data(response.authorisation.token.utf8)
                KeychainHelper.standard.save(data,service: Constants.service, account: Constants.account)
                print("response")
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion { //the completion that's returned either is failure or success, so instead of switch statement we just put " if case .failure " because we only want to check for that case
                    guard let error = error as? ServiceError else { return }
                    
                    switch error {
                    case .serverError(let string),
                            .unkown(let string),
                            .decodingError(let string):
                            self?.error = string
                        self?.error = error.localizedDescription
                    }
                }

            } receiveValue: {  response in
                UserDefaults.standard.set(response.user, forKey: "user")
                self.user = response.user
            }
            .store(in: &subscriptions)
    }

    func updateUserData(){
//        guard let name = name,
//              let phoneNumber = phoneNumber,
//              let id = Auth.auth().currentUser?.uid else { return }
//
//        let updatedFields: [String: Any] = [
//            "name": name,
//            "phoneNumber": phoneNumber
//        ]
//
//        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id)
//        //when the function recieves the bool value it performs the closure
//            .sink{ [weak self] Completion in
//                if case .failure(let error) = Completion {
//                    print(error.localizedDescription)
//                    self?.error = error.localizedDescription
//                }
//            } receiveValue: { state in
//                print("Adding user data to database: \(state)")
//            }
//            .store(in: &subscriptions)

    }



}
