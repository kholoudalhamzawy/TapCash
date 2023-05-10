//
//  kidsViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class kidsTableViewCell: UITableViewCell {
        
        static let identifier = "KidsTableViewCell"
        
        private let UIView = KidDetailsUIView()
    
        func configureTweet(with displayName: String = "khaled", number: String = "0111111111", balance: String="3000"){
            UIView.configure(balance: balance, name: displayName, phone: number)
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(UIView)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
       
        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

        }

    }
