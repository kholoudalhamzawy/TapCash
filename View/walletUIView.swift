//
//  walletUIView.swift
//  TabCash
//
//  Created by KH on 09/05/2023.
//

import UIKit

class walletUIView: UIView {
    
    
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
        imageView.contentMode = .scaleAspectFit
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
   
    public func configure(balance: String) {
        balanceDisplayLbl.text = balance
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(walletStackView)
        configurewalletStack()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func applyConstraints(){
        let walletImageViewConstraints = [
            walletImageView.widthAnchor.constraint(equalToConstant: 90),
            walletImageView.heightAnchor.constraint(equalToConstant: 90)
        ]
      
        let walletStackViewConstraints = [
            walletStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            walletStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28),
            walletStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            walletStackView.widthAnchor.constraint(equalToConstant: 400),
            walletStackView.heightAnchor.constraint(equalToConstant: 90)

        ]
        NSLayoutConstraint.activate(walletImageViewConstraints)
        NSLayoutConstraint.activate(walletStackViewConstraints)}
}
