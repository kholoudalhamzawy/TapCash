//
//  HistoryViewController.swift
//  TabCash
//
//  Created by KH on 06/05/2023.
//

import UIKit

class HistoryViewController: UIViewController {
   
    private let transactionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        configureNavigationBar()
      
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        view.addSubview(transactionsTableView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        transactionsTableView.frame = view.frame
    }
    
    func configureNavigationBar(){
      
        var image = UIImage(named: "ic-logo")
        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image:image, style: .plain, target: self, action: nil)
      
        let HistoryView = UILabel()
        HistoryView.font = UIFont(name: "Poppins-Medium", size: 24)
        HistoryView.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        HistoryView.text = "History"
        navigationItem.titleView = HistoryView
                
    }
    
    //    @objc private func didTapProfile(){
    //        let vc = ProfileViewController()
    //        navigationController?.pushViewController(vc, animated: true)
    //    }
    
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
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
        transactionsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}




