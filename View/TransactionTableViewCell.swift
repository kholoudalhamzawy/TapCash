//
//  TransactionTableViewCell.swift
//  TabCash
//
//  Created by KH on 09/05/2023.
//

import UIKit
class TransactionTableViewCell: UITableViewCell {
    
    static let identifier = "TransactionTableViewCell"
    
    
    private let transactionTypeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
      //  imageView.image = UIImage(named: "ic-recieve-arrow")
            return imageView
        
    }()
    
    private let displayAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 12)
        //label.text = "300 EGP"
        label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usersNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        label.font = UIFont(name: "Poppins-Regular", size: 12)
       // label.text = "Person To Person"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8156862745, green: 0.6901960784, blue: 0.8745098039, alpha: 1)
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.text = "Transaction ID: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        label.font = UIFont(name: "Poppins-Regular", size: 12)
      //  label.text = "TGK136549"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    
    func configureTransaction(from sender: String, to reciever: String, id: String, amount: String, transactionType: transactionType){
        switch transactionType {
        case .withdraw,
             .transfer:
            transactionTypeImageView.image = UIImage(named: "ic-send-arrow")
        case .deposit:
            transactionTypeImageView.image = UIImage(named: "ic-recieve-arrow")
            
        }
        displayAmountLabel.text = "\(amount) EGP"
        usersNameLabel.text = "\(sender) to \(reciever)"
        transactionIdLabel.text = id
    }
    
    
    private func configureConstraints() {
        let transactionTypeImageViewConstraints = [
            transactionTypeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:25),
            transactionTypeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let displayAmountLabelConstraints = [
            displayAmountLabel.leadingAnchor.constraint (equalTo: transactionTypeImageView.trailingAnchor, constant: 16),
            displayAmountLabel.topAnchor.constraint (equalTo: contentView.topAnchor, constant: 12)
        ]
        let usersNameLabelConstraints = [
            usersNameLabel.leadingAnchor.constraint (equalTo: displayAmountLabel.leadingAnchor),
            usersNameLabel.topAnchor.constraint(equalTo: displayAmountLabel.bottomAnchor, constant: 4)
        ]
        let transactionLabelConstraints = [
            transactionLabel.leadingAnchor.constraint (equalTo: displayAmountLabel.leadingAnchor),
            transactionLabel.topAnchor.constraint(equalTo: usersNameLabel.bottomAnchor, constant: 4),
            transactionIdLabel.leadingAnchor.constraint(equalTo: transactionLabel.trailingAnchor),
            transactionIdLabel.topAnchor.constraint(equalTo:  usersNameLabel.bottomAnchor, constant: 4),

        ]
        
        
            
        NSLayoutConstraint.activate(transactionTypeImageViewConstraints)
        NSLayoutConstraint.activate(displayAmountLabelConstraints)
        NSLayoutConstraint.activate(usersNameLabelConstraints)
        NSLayoutConstraint.activate(transactionLabelConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(transactionTypeImageView)
        contentView.addSubview(displayAmountLabel)
        contentView.addSubview(usersNameLabel)
        contentView.addSubview(transactionLabel)
        contentView.addSubview(transactionIdLabel)

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

