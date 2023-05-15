//
//  CashOutUIView.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

protocol CashOutUIViewDelegate: AnyObject {
    func didTabSend()
}

class CashOutUIView: UIView {
    
    weak var delegate: CashOutUIViewDelegate?
    
    private let phoneTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.setLeftPaddingPoints(10)
        txtField.text = "01010222222"
        return txtField
    }()

    
    private let amountTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string:"Enter amount", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.keyboardType = .emailAddress
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.setLeftPaddingPoints(10)
        txtField.text = "30"
        
        return txtField
    }()
    
    private let sendBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Send", for: .normal)
        btn.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapSend(){
        delegate?.didTabSend()
        
    }
    private let phoneValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.text = "Ddddddd"
        view.textAlignment = .left
        
        return view
    }()
 
    private let amountValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
//        view.text = "Ddddddd"

        return view
    }()
    
    private var headerView = walletUIView()
    
     func configureBalance(balance: String ){
        headerView.configure(balance: balance)
    }
    
     func configurePhoneError(error: String){
        phoneValidationLbl.text = error

    }
     func configureAmountError(error: String){
        amountValidationLbl.text = error
    }
   
    func getPhone() -> String? {
        return phoneTextFeild.text
    }
    func getAmount() -> String? {
        return amountTextFeild.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        addSubview(phoneValidationLbl)
        addSubview(phoneTextFeild)
        addSubview(amountValidationLbl)
        addSubview(amountTextFeild)
        addSubview(sendBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func applyConstraints(){
        let headerViewConstraints = [
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 160),
            headerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let textFieldHeight = CGFloat(44)
        let textFieldWidth = CGFloat(365)
        let textFieldSpasing = CGFloat(0)
        
        //MARK: - PHONE CONSTRAINTS
        
        let phoneTextFieldConstraints = [
            phoneTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            phoneTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            phoneTextFeild.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phoneTextFeild.topAnchor.constraint(equalTo: phoneValidationLbl.bottomAnchor)
        ]
        
        let phoneValidationLblConstraints = [
            phoneValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            phoneValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            phoneValidationLbl.leadingAnchor.constraint(equalTo: phoneTextFeild.leadingAnchor, constant: 12),
            phoneValidationLbl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)

            
        ]
      
        let amountTextFieldConstraints = [
            amountTextFeild.topAnchor.constraint(equalTo: amountValidationLbl.bottomAnchor),
            amountTextFeild.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            amountTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            amountTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth)

        ]
        
        let amountValidationLblConstraints = [
            amountValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            amountValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            amountValidationLbl.leadingAnchor.constraint(equalTo: amountTextFeild.leadingAnchor, constant: 12),
            amountValidationLbl.topAnchor.constraint(equalTo: phoneTextFeild.bottomAnchor,constant: textFieldSpasing)
            
        ]
        
        //MARK: - submitBtn CONSTRAINTS
        
        let sendBtnConstraints = [
            sendBtn.widthAnchor.constraint(equalToConstant: textFieldWidth),
            sendBtn.heightAnchor.constraint(equalToConstant: textFieldHeight),
            sendBtn.topAnchor.constraint(equalTo: amountTextFeild.bottomAnchor, constant: 32),
            sendBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ]
        NSLayoutConstraint.activate(headerViewConstraints)
        NSLayoutConstraint.activate(phoneValidationLblConstraints)
        NSLayoutConstraint.activate(phoneTextFieldConstraints)
        NSLayoutConstraint.activate(amountValidationLblConstraints)
        NSLayoutConstraint.activate(amountTextFieldConstraints)
        NSLayoutConstraint.activate(sendBtnConstraints)

    }
}


