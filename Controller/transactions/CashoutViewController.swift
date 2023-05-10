//
//  CashoutViewController.swift
//  TabCash
//
//  Created by KH on 09/05/2023.
//

import UIKit


class CashoutViewController: UIViewController {
    
    
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
