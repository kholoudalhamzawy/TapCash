//
//  DonationsViewController.swift
//  TabCash
//
//  Created by KH on 09/05/2023.
//

import UIKit

class DonationsViewController: UIViewController {

    
    private let TotalBalanceLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Light", size: 16)
        view.text = "Total Balance"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let balanceDisplayLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 32)
        view.text = "70,1050 EGP"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelsStackView = UIStackView()
    
    func configurelabelsStack(){
        labelsStackView.addArrangedSubview(TotalBalanceLbl)
        labelsStackView.addArrangedSubview(balanceDisplayLbl)
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = 6
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        labelsStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    }
        
    
    private let walletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-wallet")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let walletStackView = UIStackView()

    func configurewalletStack(){
        configurelabelsStack()
        walletStackView.addArrangedSubview(walletImageView)
        walletStackView.addArrangedSubview(labelsStackView)
        walletStackView.axis = .horizontal
        walletStackView.distribution = .fillProportionally
        walletStackView.spacing = 10
        walletStackView.translatesAutoresizingMaskIntoConstraints = false
        walletStackView.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 0.7917770487)
        walletStackView.layer.cornerRadius = 12
        walletStackView.isLayoutMarginsRelativeArrangement = true
        walletStackView.layoutMargins = UIEdgeInsets(top: 3, left: 44, bottom: 3, right: 68)

    }
    @objc func DidTapCashOut(){
       navigationController?.pushViewController(CashoutViewController(), animated: true)
    }
    
    private let transactionVStack = UIStackView()
    private let transactionVStackAssets = ["ic-resala",
                                           "ic-helal",
                                           "ic-57357",
                                           "ic-500"]
    
    private let transactionVStackLabels = ["Resala",
                                           "El Helal el Ahmer el Masry",
                                           "57357 Hospital",
                                           "500 500"]
    
    func configureTransactionVStack() {
        
        for index in 0..<transactionVStackAssets.count {
            
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Medium", size: 20)
            label.text = transactionVStackLabels[index]
            label.textAlignment = .left
            label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0

            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: transactionVStackAssets[index])
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit

            
            let subStack = UIStackView()
            subStack.axis = .horizontal
            subStack.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
            subStack.layer.cornerRadius = 12
            subStack.distribution = .fillProportionally
            subStack.spacing = 10
            subStack.translatesAutoresizingMaskIntoConstraints = false
            subStack.isLayoutMarginsRelativeArrangement = true
            subStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            subStack.addArrangedSubview(imageView)
            subStack.addArrangedSubview(label)
            subStack.widthAnchor.constraint(equalToConstant: 400).isActive = true
            subStack.heightAnchor.constraint(equalToConstant: 52).isActive = true
            subStack.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(DidTapCashOut))
            subStack.addGestureRecognizer(tap)
            
                  subStack.alignment = .leading
            imageView.centerYAnchor.constraint(equalTo: subStack.centerYAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: subStack.centerYAnchor).isActive = true
            transactionVStack.addArrangedSubview(subStack)
            
        }
        
        transactionVStack.axis = .vertical
        transactionVStack.distribution = .fillEqually
        transactionVStack.spacing = 12
        transactionVStack.translatesAutoresizingMaskIntoConstraints = false
        transactionVStack.isLayoutMarginsRelativeArrangement = true
        transactionVStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configureNavigationBar(){
      
        let transferView = UILabel()
        transferView.font = UIFont(name: "Poppins-Medium", size: 24)
        transferView.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        transferView.text = "Transactions"
        navigationItem.titleView = transferView
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(walletStackView)
        configurewalletStack()
        view.addSubview(transactionVStack)
        configureTransactionVStack()
        
//        applyConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }
    private func applyConstraints(){
        let walletImageViewBtnConstraints = [
            walletImageView.widthAnchor.constraint(equalToConstant: 90),
            walletImageView.heightAnchor.constraint(equalToConstant: 90)
        ]
        let walletStackViewConstraints = [
            walletStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            walletStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            walletStackView.widthAnchor.constraint(equalToConstant: 400)
            
        ]
        let transactionVStackConstraints = [
            transactionVStack.topAnchor.constraint(equalTo: walletStackView.bottomAnchor, constant: 32),
            transactionVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(walletImageViewBtnConstraints)
        NSLayoutConstraint.activate(walletStackViewConstraints)
        NSLayoutConstraint.activate(transactionVStackConstraints)
    }


}
