//
//  CategoriesViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let amountTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter Amount Per Day EGP", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.setLeftPaddingPoints(15)
        return txtField
        
    }()
    private let CategoriesLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 24)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.numberOfLines = 0
        view.text = "Select Categories"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    private let addBtnValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "fkfkfkkkggg"
        view.textAlignment = .left
        return view
    }()
    
    @objc func togglecheck( _ sender: UIButton ) {
        let image = sender.currentImage == UIImage(named: "ic-unchecked") ? UIImage(named: "ic-check") : UIImage(named: "ic-unchecked")
        sender.setImage(image, for: .normal)
    }
    
    private let categories = ["Food", "Clothes", "Travel", "Health", "Drinks", "Games", "Send Money", "Lessons"]
    
    private let categoriesLeftStack = UIStackView()
    private let categoriesRightStack = UIStackView()
    
    func configurepCategoriesStacks() {
        
        for index in 0..<8 {
            
            let StackLabel: UILabel = {
               let lbl = UILabel()
               lbl.frame = CGRect(x: 0, y: 0, width: 94, height: 17)
               lbl.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
               lbl.font = UIFont(name: "Poppins-Regular", size: 20)
               lbl.translatesAutoresizingMaskIntoConstraints = false
               lbl.text = categories[index]

               return lbl
           }()
           
            let isChecked : UIButton = {
               let btn = UIButton()
               btn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
               btn.setImage(UIImage(named: "ic-unchecked"), for: .normal)
               btn.addTarget(self, action: #selector(togglecheck), for: .touchUpInside)
               btn.translatesAutoresizingMaskIntoConstraints = false
               return btn
               
           }()
            
            let subStack = UIStackView(arrangedSubviews: [isChecked,StackLabel])
            subStack.axis = .horizontal
            subStack.distribution = .fillProportionally
            subStack.spacing = 14
            subStack.translatesAutoresizingMaskIntoConstraints = false
            
            if index < 4 {
                categoriesLeftStack.addArrangedSubview(subStack)
            } else {
                categoriesRightStack.addArrangedSubview(subStack)
            }
        }
        categoriesLeftStack.axis = .vertical
        categoriesLeftStack.distribution = .fillProportionally
        categoriesLeftStack.spacing = 28
        categoriesLeftStack.alignment = .leading
        categoriesLeftStack.translatesAutoresizingMaskIntoConstraints = false
        categoriesLeftStack.isLayoutMarginsRelativeArrangement = true
        categoriesLeftStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        
        categoriesRightStack.axis = .vertical
        categoriesRightStack.distribution = .fillProportionally
        categoriesRightStack.spacing = 28
        categoriesRightStack.alignment = .leading
        categoriesRightStack.translatesAutoresizingMaskIntoConstraints = false
        categoriesRightStack.isLayoutMarginsRelativeArrangement = true
        categoriesRightStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        
      
        scrollView.addSubview(categoriesLeftStack)
        scrollView.addSubview(categoriesRightStack)
        
    }
    
    var isExpand : Bool = false
    @objc func keyboardApear(){
        if !isExpand {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }
    @objc func keyboardDisapear(){
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
            self.isExpand = false
        }
    }
    
    private let addBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Add Child", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(backToTable), for: .touchUpInside)
        return btn
    }()
    @objc func backToTable(){
        navigationController?.popToRootViewController(animated: false)
    }
    
    
    func configureNavigationBar(){
        let addAcc = UILabel()
        addAcc.font = UIFont(name: "Poppins-Medium", size: 24)
        addAcc.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        addAcc.text = "Add Account"
        navigationItem.titleView = addAcc
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(addBtnValidationLbl)
        scrollView.addSubview(amountTextFeild)
        scrollView.addSubview(CategoriesLbl)
        configurepCategoriesStacks()
        scrollView.addSubview(addBtn)
        applyConstraints()
        configureNavigationBar()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
    }
    
    @objc private func didTapToDismiss(){
        view.endEditing(true)
    }
    
    
    private func applyConstraints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let amountTextFieldConstraints = [
            amountTextFeild.widthAnchor.constraint(equalToConstant: 365),
            amountTextFeild.heightAnchor.constraint(equalToConstant: 48),
            amountTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            amountTextFeild.topAnchor.constraint(equalTo: addBtnValidationLbl.bottomAnchor, constant: 8)
        ]
        let addBtnValidationLblConstraints = [
            addBtnValidationLbl.widthAnchor.constraint(equalToConstant: 365),
            addBtnValidationLbl.heightAnchor.constraint(equalToConstant: 38),
            addBtnValidationLbl.leadingAnchor.constraint(equalTo: amountTextFeild.leadingAnchor, constant: 12),
            addBtnValidationLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32)
            
        ]
        
        let CategoriesLblConstraints = [
            CategoriesLbl.widthAnchor.constraint(equalToConstant: 365),
            CategoriesLbl.heightAnchor.constraint(equalToConstant: 48),
            CategoriesLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            CategoriesLbl.topAnchor.constraint(equalTo: amountTextFeild.bottomAnchor, constant: 32)
        ]
        let categoriesLeftStackConstraints = [
            categoriesLeftStack.topAnchor.constraint(equalTo: CategoriesLbl.bottomAnchor, constant: 32),
            categoriesLeftStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor ,constant: 20),

        ]
        let categoriesRightStackConstraints = [
            categoriesRightStack.topAnchor.constraint(equalTo: CategoriesLbl.bottomAnchor, constant: 32),
            categoriesRightStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ]
        
      
        let addBtnConstraints = [
            addBtn.widthAnchor.constraint(equalToConstant: 365),
            addBtn.heightAnchor.constraint(equalToConstant: 48),
            addBtn.topAnchor.constraint(equalTo: categoriesRightStack.bottomAnchor, constant: 36),
            addBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ]
                                                            
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(amountTextFieldConstraints)
        NSLayoutConstraint.activate(CategoriesLblConstraints)
        NSLayoutConstraint.activate(categoriesLeftStackConstraints)
        NSLayoutConstraint.activate(categoriesRightStackConstraints)
        NSLayoutConstraint.activate(addBtnValidationLblConstraints)
        NSLayoutConstraint.activate(addBtnConstraints)
    }
}
