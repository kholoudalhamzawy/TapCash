//
//  kidsViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class kidsTableViewCell: UITableViewCell {
        
        static let identifier = "KidsTableViewCell"
        private let actionSpacing : CGFloat = 60
        
        private let UIView = KidDetailsUIView()
    
        func configureTweet(with displayName: String = "khaled", number: String = "0111111111", balance: String="3000"){
            UIView.configure(balance: balance, name: displayName, phone: number)
            UIView.frame = contentView.frame

        }
        
        
        
        private func configureConstraints() {
//            let UIViewConstraints = [
//            UIView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: -20),
//            UIView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: 20),
//
//            UIView.topAnchor.constraint (equalTo: contentView.topAnchor),
//            UIView.heightAnchor.constraint (equalToConstant: 95),
//            UIView.widthAnchor.constraint (equalToConstant:400),
//            UIView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//            ]
            
//            NSLayoutConstraint.activate(UIViewConstraints)
            
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(UIView)
            configureConstraints()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        

        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
