//
//  KidDetailsUIView.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class KidDetailsUIView: UIView {
    
    private let availableBalanceLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 112, height: 8)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 16)
        view.text = "Available to spend"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let balanceDisplayLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 98, height: 14)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 20)
        view.text = "3,000 EGP"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let leftLabelsStackView = UIStackView()
    
    func configureLeftLabelsStack(){
        leftLabelsStackView.addArrangedSubview(balanceDisplayLbl)
        leftLabelsStackView.addArrangedSubview(availableBalanceLbl)
        leftLabelsStackView.axis = .vertical
        leftLabelsStackView.distribution = .fillProportionally
        leftLabelsStackView.spacing = 12
        leftLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        leftLabelsStackView.isLayoutMarginsRelativeArrangement = true
        
    }
    private let nameLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 95, height: 17)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 24)
        view.text = "KHALED"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let phoneLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 16)
        view.text = "01234567898"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let rightLabelsStackView = UIStackView()
    
    func configureRightLabelsStackView(){
        rightLabelsStackView.addArrangedSubview(nameLbl)
        rightLabelsStackView.addArrangedSubview(phoneLbl)
        rightLabelsStackView.axis = .vertical
        rightLabelsStackView.distribution = .fillProportionally
        rightLabelsStackView.spacing = 10
        rightLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        rightLabelsStackView.isLayoutMarginsRelativeArrangement = true
        
    }
    
    
    
    private let detailsStackView = UIStackView()
    
    func configuredetailsStackView(){
        configureLeftLabelsStack()
        configureRightLabelsStackView()
        detailsStackView.addArrangedSubview(rightLabelsStackView)
        detailsStackView.addArrangedSubview(leftLabelsStackView)
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .fillProportionally
        detailsStackView.spacing = 50
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 0.7917770487)
        detailsStackView.layer.cornerRadius = 12
        detailsStackView.isLayoutMarginsRelativeArrangement = true
        detailsStackView.layoutMargins = UIEdgeInsets(top: 24, left: 18, bottom: 24, right: 18)
        
    }
    
    public func configure(balance: String, name: String, phone: String) {
        balanceDisplayLbl.text = balance
        nameLbl.text = name
        phoneLbl.text = phone
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detailsStackView)
        configuredetailsStackView()
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
        
        let detailsStackViewConstraints = [
            detailsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            detailsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            detailsStackView.widthAnchor.constraint(equalToConstant: 400),
            detailsStackView.heightAnchor.constraint(equalToConstant: 95)
            
        ]
        NSLayoutConstraint.activate(detailsStackViewConstraints)
    }
    
    
}
