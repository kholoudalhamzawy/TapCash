//
//  kidsAccountsViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class kidsAccountsViewController: UIViewController{

    private let kidsAccountsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(kidsTableViewCell.self, forCellReuseIdentifier: kidsTableViewCell.identifier)
        return tableView
    }()
    func configureNavigationBar(){
      
        let KidsView = UILabel()
        KidsView.font = UIFont(name: "Poppins-Medium", size: 24)
        KidsView.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        KidsView.text = "Kids"
        navigationItem.titleView = KidsView
                
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(kidsAccountsTableView)
        kidsAccountsTableView.delegate = self
        kidsAccountsTableView.dataSource = self
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlus))
//        bindViews()

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        kidsAccountsTableView.frame = view.frame
        configureConstraints()
    }
    @objc private func didTapPlus(){
        navigationController?.pushViewController(SignUpKidViewController(), animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //this will make the navigation bar appear again after it's hidden in the profile controller
        navigationController?.navigationBar.isHidden = false
//        handleAuthentication()
//        viewModel.retrieveUser()


    }
    
//    func bindViews(){
//        viewModel.$user.sink{ [weak self] user in
//            guard let user = user else { return }
//            if !user.isUserOnboarded {
//                self?.completeUserOnboarding()
//            }
//        }.store(in: &subscriptions)
//
//        viewModel.$tweets.sink{ [weak self] _ in
//            DispatchQueue.main.async {
//                self?.timelineTableView.reloadData()
//            }
//        }.store(in: &subscriptions)
//    }
    
    private func configureConstraints(){
      
        
    }
    
//    private func handleAuthentication(){
//            if Auth.auth().currentUser == nil {
//                let vc = UINavigationController(rootViewController: OnboardingViewController())
//                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: false)
//                DispatchQueue.main.async {
//                    self.timelineTableView.reloadData()
//                }
//            }
//    }
    
    

}

extension kidsAccountsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kidsTableViewCell.identifier, for: indexPath) as? kidsTableViewCell else {
            return UITableViewCell()
        }
        
//        let tweetModel = viewModel.tweets[indexPath.row]
//        cell.configureTweet(with: tweetModel.author.displayName,
//                            username: tweetModel.author.username,
//                            tweetTextContent: tweetModel.tweetContent,
//                            avatarPath: tweetModel.author.avatarPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        kidsAccountsTableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(KidDetailViewController(), animated: true)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
