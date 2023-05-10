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
        
//        guard let request = Endpoint.createAccount(userRequest: userRequest).request else { return }
        
        var request = URLRequest(url: URL(string:"https://tapcash.000webhostapp.com/api/tapcash/orange/v1/register")!)
                                 
        AuthManager.shared.publisher(request: request, token: nil)
            .decode(type: Response.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { response in
                let data = Data(response.authorisation.token.utf8)
                UserDefaults.standard.set(response.user.name, forKey: "username")

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

//    func fetchTweets(){
//        guard let id = user?.id else { return }
//        DatabaseManager.shared.collectionTweets(retrieveTweets: id)
//            .sink{ [weak self] Completion in
//                if case .failure(let error) = Completion {
//                    self?.error = error.localizedDescription }
//            } receiveValue: { [weak self] retrievedTweets in
//                self?.tweets = retrievedTweets
//            }
//            .store(in: &subscriptions) //this is for memory management, the subscriptions: Set<AnyCancellable> cancells all the subsciptions that's in it when the viewModel is deleted
//    }
}
