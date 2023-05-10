//
//  HomeViewController.swift
//  TabCash
//
//  Created by KH on 06/05/2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()
   
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
        view.text = "70,000 EGP"
        view.textAlignment = .center
        view.numberOfLines = 0
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
        scrollView.addSubview(walletStackView)

    }
    
    private let vscrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true 
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let transactionVStack = UIStackView()
    private let transactionVStackAssets = ["ic-donations",
                                           "ic-cashin",
                                           "ic-cashout",
                                           "ic-scan",
                                           "ic-digital-card",
                                           "ic-bitcoin"]
    
    private let transactionVStackLabels = ["Donations",
                                           "Cash in",
                                           "Cash out",
                                           "QR Scan",
                                           "Smart Cards",
                                           "Online Bills"]
    
    func configureTransactionVStack() {
        
        for index in 0..<transactionVStackAssets.count {
            
            let label = UILabel()
            label.font = UIFont(name: "Poppins-Medium", size: 12)
            label.text = transactionVStackLabels[index]
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0

            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: transactionVStackAssets[index])
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
            view.layer.cornerRadius = 12
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 62).isActive = true
            view.heightAnchor.constraint(equalToConstant: 62).isActive = true
            view.addSubview(imageView)
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            
            let subStack = UIStackView()
            subStack.axis = .vertical
            subStack.distribution = .fill
            subStack.spacing = 8
            subStack.translatesAutoresizingMaskIntoConstraints = false
            subStack.isLayoutMarginsRelativeArrangement = true
            subStack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            subStack.addArrangedSubview(view)
            subStack.addArrangedSubview(label)

            transactionVStack.addArrangedSubview(subStack)
            
        }
        
        transactionVStack.axis = .horizontal
        transactionVStack.distribution = .fillProportionally
        transactionVStack.spacing = 30
        transactionVStack.translatesAutoresizingMaskIntoConstraints = false
        transactionVStack.isLayoutMarginsRelativeArrangement = true
        transactionVStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        vscrollView.addSubview(transactionVStack)
    }
    
    
    private let paymentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false

        return scrollView
    }()
    
    private let paymentVStack = UIStackView()

    private let paymentVStackAssets = ["ic-mobile",
                                           "ic-teacher",
                                           "ic-donations"]
    
    private let paymentVStackLabels = ["Online Payment",
                                           "Schools and University",
                                           "Donations (Charity)"]
                                           
    
      func configurepPymentsVStack() {
          
          for index in 0..<paymentVStackLabels.count {
              
              let label = UILabel()
              label.font = UIFont(name: "Poppins-Regular", size: 12)
              label.text = paymentVStackLabels[index]
              label.textAlignment = .center
              label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
              label.translatesAutoresizingMaskIntoConstraints = false

              
              let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
              imageView.translatesAutoresizingMaskIntoConstraints = false
              imageView.image = UIImage(named: paymentVStackAssets[index])
              imageView.isUserInteractionEnabled = true
              imageView.contentMode = .scaleAspectFit
              
              
              
              let subStack = UIStackView()
              subStack.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9019607843, blue: 0.9607843137, alpha: 1)
              subStack.layer.cornerRadius = 12
              subStack.axis = .vertical
              subStack.distribution = .fillProportionally
              subStack.spacing = 0
              subStack.translatesAutoresizingMaskIntoConstraints = false
              subStack.isLayoutMarginsRelativeArrangement = true
              subStack.layoutMargins = UIEdgeInsets(top: 8, left: 13, bottom: 8, right: 0)
              subStack.alignment = .leading
              
              subStack.addArrangedSubview(imageView)
              subStack.addArrangedSubview(label)

              subStack.widthAnchor.constraint(equalToConstant: 170).isActive = true
              paymentVStack.addArrangedSubview(subStack)
              
          }
          
          paymentVStack.axis = .horizontal
          paymentVStack.distribution = .fillProportionally
          paymentVStack.spacing = 24
          paymentVStack.translatesAutoresizingMaskIntoConstraints = false
          paymentVStack.isLayoutMarginsRelativeArrangement = true
          paymentVStack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
          paymentScrollView.addSubview(paymentVStack)
      }
    
    
    private let paymentLbl: UILabel = {
        var view = UILabel()
        view.font =  UIFont(name: "Poppins-Medium", size: 16)
        view.text = "Payment"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seeAllLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 12)
        view.text = "See All"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.8156862745, green: 0.6901960784, blue: 0.8745098039, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    
    private let AdImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 165))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "AD")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let Ad2ImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 165))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "AD2")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let lastTransactionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        configureNavigationBar()

        view.addSubview(scrollView)
        configurewalletStack()

        scrollView.addSubview(vscrollView)
        configureTransactionVStack()

        scrollView.addSubview(paymentScrollView)
        configurepPymentsVStack()

        scrollView.addSubview(paymentLbl)
        scrollView.addSubview(seeAllLbl)
        scrollView.addSubview(AdImageView)
        scrollView.addSubview(Ad2ImageView)
//
//        
//        let vc = UINavigationController(rootViewController: logInViewController())
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lastTransactionsTableView.frame = view.frame
        applyConstarints()
    }
   
    private func applyConstarints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let walletImageViewBtnConstraints = [
            walletImageView.widthAnchor.constraint(equalToConstant: 90),
            walletImageView.heightAnchor.constraint(equalToConstant: 90)
        ]
        let walletStackViewConstraints = [
            walletStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            walletStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            walletStackView.widthAnchor.constraint(equalToConstant: 400)
            
        ]
        let vscrollViewConstraints = [
            vscrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vscrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vscrollView.topAnchor.constraint(equalTo: walletStackView.bottomAnchor, constant: 12),
            vscrollView.heightAnchor.constraint(equalToConstant: 115)
        ]
        let transactionVStackConstraints = [
            transactionVStack.topAnchor.constraint(equalTo: vscrollView.topAnchor),
            transactionVStack.leadingAnchor.constraint(equalTo: vscrollView.leadingAnchor),
            transactionVStack.trailingAnchor.constraint(equalTo: vscrollView.trailingAnchor)
        ]
        let paymentscrollViewConstraints = [
            paymentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentScrollView.topAnchor.constraint(equalTo: transactionVStack.bottomAnchor, constant: 50),
            paymentScrollView.heightAnchor.constraint(equalToConstant: 70)
        ]
        let paymentVStackConstraints = [
            paymentVStack.topAnchor.constraint(equalTo: paymentScrollView.topAnchor),
            paymentVStack.leadingAnchor.constraint(equalTo: paymentScrollView.leadingAnchor),
            paymentVStack.trailingAnchor.constraint(equalTo: paymentScrollView.trailingAnchor)
        ]
        let paymentLblConstraints = [
            paymentLbl.bottomAnchor.constraint(equalTo: paymentScrollView.topAnchor, constant: -10),
            paymentLbl.leadingAnchor.constraint(equalTo: paymentScrollView.leadingAnchor, constant: 20)
        ]
        let seeAllLblConstraints = [
            seeAllLbl.bottomAnchor.constraint(equalTo: paymentScrollView.topAnchor, constant: -10),
            seeAllLbl.trailingAnchor.constraint(equalTo: paymentScrollView.trailingAnchor, constant: -20)
        ]
        let AdImageViewConstraints = [
            AdImageView.topAnchor.constraint(equalTo: paymentScrollView.bottomAnchor, constant: 24),
            AdImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ]
        let Ad2ImageViewConstraints = [
            Ad2ImageView.topAnchor.constraint(equalTo: AdImageView.bottomAnchor, constant: 12),
            Ad2ImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ]
       
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(walletImageViewBtnConstraints)
        NSLayoutConstraint.activate(walletStackViewConstraints)
        NSLayoutConstraint.activate(vscrollViewConstraints)
        NSLayoutConstraint.activate(transactionVStackConstraints)
        NSLayoutConstraint.activate(paymentscrollViewConstraints)
        NSLayoutConstraint.activate(paymentVStackConstraints)
        NSLayoutConstraint.activate(paymentLblConstraints)
        NSLayoutConstraint.activate(seeAllLblConstraints)
        NSLayoutConstraint.activate(AdImageViewConstraints)
        NSLayoutConstraint.activate(Ad2ImageViewConstraints)

    }

    func configureNavigationBar(){
        let size: CGFloat = 40
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "ic-logo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapLogOut))
    }
    
    @objc private func didTapLogOut(){
        let vc = logInViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: false)

        navigationController?.pushViewController(vc, animated: true)
    }
    
}

