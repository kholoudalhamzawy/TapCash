//
//  KidDetailViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit

class KidDetailViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    func configureNavigationBar(){
      
        let KidsView = UILabel()
        KidsView.font = UIFont(name: "Poppins-Medium", size: 24)
        KidsView.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        KidsView.text = "Kids"
        navigationItem.titleView = KidsView
                
    }
    private let nameTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Child Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.text = "khaled"
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.frame = CGRect(x: 0, y: 0, width: 87, height: 17)
        txtField.setLeftPaddingPoints(15)
        return txtField
        
    }()
    private let numberTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.frame = CGRect(x: 0, y: 0, width: 78, height: 8)
        txtField.textAlignment = .left
        txtField.text = "01234567898"
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
    private let amountTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter The Amount Per Day EGP", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.text = "3000"
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
    
    private let kidsDetailsView: KidDetailsUIView = {
        var view = KidDetailsUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.configure(balance:  name: <#T##String#>, phone: <#T##String#>)
//        view.text = "Ddddddd"
        return view
    }()
    
    
    private let CategoriesLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 24)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.numberOfLines = 0
        view.text = "Edit Categories"
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let editBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Edit", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(scrollView)
        scrollView.addSubview(kidsDetailsView)
        scrollView.addSubview(nameTextFeild)
        scrollView.addSubview(numberTextFeild)
        scrollView.addSubview(amountTextFeild)
        scrollView.addSubview(CategoriesLbl)
        configurepCategoriesStacks()
        scrollView.addSubview(editBtn)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }
    private func applyConstraints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let kidsDetailsViewBtnConstraints = [
            kidsDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            kidsDetailsView.heightAnchor.constraint(equalToConstant: 160),
            kidsDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            kidsDetailsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
            
            let textFieldHeight = CGFloat(44)
            let textFieldWidth = CGFloat(365)
        
        let nameTxtFieldConstraints = [
            nameTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            nameTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            nameTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameTextFeild.topAnchor.constraint(equalTo: kidsDetailsView.bottomAnchor, constant: 18)
            
        ]
        let numberTxtFieldConstraints = [
            numberTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            numberTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            numberTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            numberTextFeild.topAnchor.constraint(equalTo: nameTextFeild.bottomAnchor, constant: 14)
            
        ]
        let amountTxtFieldConstraints = [
            amountTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            amountTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            amountTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            amountTextFeild.topAnchor.constraint(equalTo: numberTextFeild.bottomAnchor, constant: 14)
            
        ]
        let CategoriesLblConstraints = [
            CategoriesLbl.widthAnchor.constraint(equalToConstant: 365),
            CategoriesLbl.heightAnchor.constraint(equalToConstant: 48),
            CategoriesLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            CategoriesLbl.topAnchor.constraint(equalTo: amountTextFeild.bottomAnchor, constant: 32)
        ]
        let categoriesLeftStackConstraints = [
            categoriesLeftStack.topAnchor.constraint(equalTo: CategoriesLbl.bottomAnchor, constant: 28),
            categoriesLeftStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor ,constant: 20),

        ]
        let categoriesRightStackConstraints = [
            categoriesRightStack.topAnchor.constraint(equalTo: CategoriesLbl.bottomAnchor, constant: 28),
            categoriesRightStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ]
        
      
        let editBtnConstraints = [
            editBtn.widthAnchor.constraint(equalToConstant: 365),
            editBtn.heightAnchor.constraint(equalToConstant: 48),
            editBtn.topAnchor.constraint(equalTo: categoriesRightStack.bottomAnchor, constant: 36),
            editBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            ]
               
        
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(kidsDetailsViewBtnConstraints)
        NSLayoutConstraint.activate(nameTxtFieldConstraints)
        NSLayoutConstraint.activate(numberTxtFieldConstraints)
        NSLayoutConstraint.activate(amountTxtFieldConstraints)
        NSLayoutConstraint.activate(CategoriesLblConstraints)
        NSLayoutConstraint.activate(categoriesLeftStackConstraints)
        NSLayoutConstraint.activate(categoriesRightStackConstraints)
        NSLayoutConstraint.activate(editBtnConstraints)

    }



}
