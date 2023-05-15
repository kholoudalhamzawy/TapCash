//
//  CashoutViewController.swift
//  TabCash
//
//  Created by KH on 09/05/2023.
//

import UIKit
import Combine

class CashoutViewController: UIViewController {
    
    
    private var viewModel = TransactionsViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let cashOutTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tableView
    }()
    
    private var headerView: CashOutUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
      
        cashOutTableView.delegate = self
        cashOutTableView.dataSource = self
        view.addSubview(cashOutTableView)
        
        headerView = CashOutUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        cashOutTableView.tableHeaderView = headerView
         let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }

    
    private func configureWalletHeaderView() {

//        APICaller.shared.getTrendingMovies { [weak self] result in
//            switch result {
//            case .success(let titles):
//                let selectedTitle = titles.randomElement()
//
//                self?.randomTrendingMovie = selectedTitle
//                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
//
//            case .failure(let erorr):
//                print(erorr.localizedDescription)
//            }
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView?.delegate = self
        bindViews()

    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cashOutTableView.frame = view.frame
        
    }
    func configureNavigationBar(){
      
        var image = UIImage(named: "ic-logo")
        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image:image, style: .plain, target: self, action: nil)
      
        let CashOut = UILabel()
        CashOut.font = UIFont(name: "Poppins-Medium", size: 24)
        CashOut.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        CashOut.text = "Cash Out"
        navigationItem.titleView = CashOut
                
    }
    
    private func bindViews(){

        AuthenticationViewViewModel.auth.$balance.sink{ [weak self] balance in
            guard let balance = balance else {return}
            self?.headerView?.configureBalance(balance: balance)

        }
        .store(in: &self.subscriptions)

            viewModel.$iscashoutFormValid.sink{ [weak self] validationState in
                if validationState {
                    self?.viewModel.cashout()
                }

        }
        .store(in: &self.subscriptions)

        viewModel.$error.sink{ [weak self] errorString in
            guard let error = errorString else { return } //guard let cause $error is an optional
            self?.presentAlert(with: error)
            print(error)

        }
        .store(in: &subscriptions)

            self.viewModel.$phoneNumberError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.headerView?.configurePhoneError(error: error)
        }.store(in: &self.subscriptions)

            self.viewModel.$amountError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.headerView?.configureAmountError(error: error)
        }.store(in: &self.subscriptions)
        }
    

        private func presentAlert(with error: String) {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "ok", style: .default)
            alert.addAction(okayButton)
            present(alert, animated: true)
        }

}


extension CashoutViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return viewModel.tweets.count
        return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        
        //        let tweetModel = viewModel.tweets[indexPath.row]
        //        cell.configureTweet(with: tweetModel.author.displayName,
        //                            username: tweetModel.author.username,
        //                            tweetTextContent: tweetModel.tweetContent,
        //                            avatarPath: tweetModel.author.avatarPath)
        
        cell.configureTransaction(from: "ahmed", to: "mohammed", id: "tojoijd", amount: String(499), transactionType: .transfer)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cashOutTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    

}

extension CashoutViewController: CashOutUIViewDelegate{
    
    func didTabSend() {
        viewModel.phoneNumber = headerView?.getPhone()
        viewModel.amount = headerView?.getAmount()
        viewModel.validateCashoutForm()
    }
    
    
    
}
