//
//  BalanceViewModel.swift
//  TabCash
//
//  Created by KH on 08/05/2023.
//

import Foundation
import Combine

final class HomeViewViewModel: ObservableObject{
    
    
    @Published var user: User?
    @Published var error: String?
    @Published var Balance: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func getBalance() {
        DataManager.shared.getBalance { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    AuthenticationViewViewModel.auth.balance = response.data.balance
                    let balance = Data( response.data.balance.utf8)
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
