//
//  TransactionsViewViewModel.swift
//  TabCash
//
//  Created by KH on 14/05/2023.
//

import Foundation

import Foundation
import Combine

final class TransactionsViewViewModel: ObservableObject{
    
    @Published var phoneNumber: String?
    @Published var amount: String?
    @Published var phoneNumberError: String?
    @Published var amountError: String?
    @Published var iscashoutFormValid: Bool = false
    @Published var error: String?
    
    private var viewModel = TransactionsViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
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
    
    func invalidamountMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        } else if text.count < 2 {
            return "* number must be atleast 10 EGP *"
        }
        return ""

    }
    
    
    func validateCashoutForm(){
        guard let phone = phoneNumber, let amount = amount else {
            iscashoutFormValid = false
            return
        }
        

        phoneNumberError = invalidPhoneMessage(phone)
        amountError = invalidamountMessage(amount)
        iscashoutFormValid = phoneNumberError!.isEmpty &&
                                  amountError!.isEmpty

    }
    
    func cashout() {
        
        guard let phone = phoneNumber, let amount = amount else { return }
        
        var cashoutRequest = TransferRequest(amount: amount, phone: phone)
        DataManager.shared.transfer(parameters: cashoutRequest.parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    AuthenticationViewViewModel.auth.balance = response.data.blanceAfter
                    let balance = Data( response.data.blanceAfter.utf8)
                    KeychainHelper.standard.save(balance, service: Constants.service, account: Constants.account)
                    
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
}
