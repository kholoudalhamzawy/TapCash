//
//  SignUpKidViewController.swift
//  TabCash
//
//  Created by KH on 10/05/2023.
//

import UIKit
import Combine

class SignUpKidViewController: UIViewController {
    
    private var viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    private let passwordStackView = UIStackView()
    private let passwordConfirmStackView = UIStackView()
    
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    
    private let signUpLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 32)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.numberOfLines = 0
        view.text = "Add a new child"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.setLeftPaddingPoints(10)
        return txtField
    }()
    
    
    private let mailTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string:"E-mail", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
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
        
        return txtField
    }()
    
    private let phoneTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.layer.cornerRadius = 12
        txtField.layer.borderWidth = 0.5
        txtField.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1) //tint color is the color of the curser poiter
        txtField.setLeftPaddingPoints(10)
        return txtField
    }()
    
    private let passwordTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.isSecureTextEntry = true
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.setLeftPaddingPoints(10)
        
        return txtField
        
    }()
    private let isHidden : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic-eye"), for: .normal)
        btn.addTarget(self, action: #selector(toggleHidingPassword), for: .touchUpInside)
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    @objc func toggleHidingPassword() {
        passwordTextFeild.isSecureTextEntry = passwordTextFeild.isSecureTextEntry ? false : true
    }
    
    func configurePasswordStackView(){
        
        passwordStackView.addArrangedSubview(passwordTextFeild)
        passwordStackView.addArrangedSubview(isHidden)
        
        passwordStackView.axis = .horizontal
        passwordStackView.distribution = .fillProportionally
        passwordStackView.spacing = 10
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.layer.cornerRadius = 12
        passwordStackView.layer.borderWidth = 0.5
        passwordStackView.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        passwordStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        passwordStackView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(passwordStackView)
        
    }
    
    
    
    private let passwordConfermationTextFeild: UITextField = {
        let txtField = UITextField()
        txtField.attributedPlaceholder =  NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Regular", size: 20)
        txtField.isSecureTextEntry = true
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        txtField.setLeftPaddingPoints(10)
        
        return txtField
        
    }()
    
    
    private let isConfirmHidden : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"ic-eye"), for: .normal)
        btn.addTarget(self, action: #selector(toggleHidingConfirmationPassword), for: .touchUpInside)
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    
    @objc func toggleHidingConfirmationPassword() {
        passwordConfermationTextFeild.isSecureTextEntry = passwordConfermationTextFeild.isSecureTextEntry ? false : true
    }
    
    
    func configurePasswordConfirmStackView(){
        
        passwordConfirmStackView.addArrangedSubview(passwordConfermationTextFeild)
        passwordConfirmStackView.addArrangedSubview(isConfirmHidden)
        
        passwordConfirmStackView.axis = .horizontal
        passwordConfirmStackView.distribution = .fillProportionally
        passwordConfirmStackView.spacing = 10
        passwordConfirmStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmStackView.layer.cornerRadius = 12
        passwordConfirmStackView.layer.borderWidth = 0.5
        passwordConfirmStackView.layer.borderColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        passwordConfirmStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        passwordConfirmStackView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(passwordConfirmStackView)
        
    }
    
    private let signUpBtn: UIButton = {
        
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Next", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        return btn
    }()
    
    @objc func didTapSignup(){
        
        navigationController?.pushViewController(CategoriesViewController(), animated: true)

        //        viewModel.password = passwordTextFeild.text
        //        viewModel.email = mailTextFeild.text
        //        viewModel.name = nameTextFeild.text
        //        viewModel.phoneNumber = phoneTextFeild.text
        //        viewModel.confirmPassword = passwordConfermationTextFeild.text
        //        viewModel.validateAuthenticationsignUpForm()
    }
    
    //MARK: - TEXT VALIDATION
    
    private let mailValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()
    
    private let phoneValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    private let passwordValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()
    private let passwordConfirmationValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()
    
    private let nameValidationLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()
    
    var errorLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(signUpLbl)
        scrollView.addSubview(mailValidationLbl)
        scrollView.addSubview(mailTextFeild)
        scrollView.addSubview(passwordValidationLbl)
        configurePasswordStackView()
        scrollView.addSubview(phoneValidationLbl)
        scrollView.addSubview(phoneTextFeild)
        scrollView.addSubview(passwordConfirmationValidationLbl)
        configurePasswordConfirmStackView()
        scrollView.addSubview(nameValidationLbl)
        scrollView.addSubview(nameTextFeild)
        scrollView.addSubview(signUpBtn)
        
        applyConstarints()
        bindViews()
        configureNavigationBar()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        
        
        nameTextFeild.text = "kholoud"
        mailTextFeild.text = "kh@kh.com"
        passwordTextFeild.text = "Kh123456"
        passwordConfermationTextFeild.text = "Kh123456"
        phoneTextFeild.text = "12345678900"
        
        
    }
    
    @objc private func didTapToDismiss(){
        view.endEditing(true)
    }
    private func bindViews(){
        
        //        viewModel.$isAuthenticationFormValid.sink{ [weak self] validationState in
        //            self?.viewModel.createUser()
        //        }
        //        .store(in: &subscriptions)
        //
        //        viewModel.$user.sink{ [weak self] user in //when we get a user from the view model
        //            guard user != nil else {return}
        //
        //          //  self?.viewModel.updateUserData()
        //            self?.navigationController?.pushViewController(uploadPhotoViewController(), animated: true)
        //
        //
        //        }
        //        .store(in: &subscriptions)
        //
        //        viewModel.$error.sink{ [weak self] errorString in
        //            guard let error = errorString else { return }
        //                self?.presentAlert(with: error)
        //        }
        //        .store(in: &subscriptions)
        //
        //        viewModel.$nameError.sink{  [weak self] errorString in
        //            guard let error = errorString else { return }
        //            self?.nameValidationLbl.text = error
        //        }.store(in: &subscriptions)
        //
        //        viewModel.$emailError.sink{  [weak self] errorString in
        //            guard let error = errorString else { return }
        //            self?.mailValidationLbl.text = error
        //        }.store(in: &subscriptions)
        //
        //        viewModel.$passwordError.sink{  [weak self] errorString in
        //            guard let error = errorString else { return }
        //            self?.passwordValidationLbl.text = error
        //        }.store(in: &subscriptions)
        //
        //        viewModel.$passwordConfirmError.sink{  [weak self] errorString in
        //            guard let error = errorString else { return }
        //            self?.passwordConfirmationValidationLbl.text = error
        //        }.store(in: &subscriptions)
        //
        //        viewModel.$phoneError.sink{  [weak self] errorString in
        //            guard let error = errorString else { return }
        //            self?.phoneValidationLbl.text = error
        //        }.store(in: &subscriptions)
    }
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    
    func configureNavigationBar(){
        let addAcc = UILabel()
        addAcc.font = UIFont(name: "Poppins-Medium", size: 24)
        addAcc.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        addAcc.text = "Add Account"
        navigationItem.titleView = addAcc
                
    }
    
    private func applyConstarints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let signUplblConstraints = [
            
            signUpLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            signUpLbl.widthAnchor.constraint(equalToConstant: 400),
            signUpLbl.heightAnchor.constraint(equalToConstant: 60),
            signUpLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ]
        
        //MARK: - NAME CONSTRAINTS
        
        let textFieldHeight = CGFloat(48)
        let textFieldWidth = CGFloat(365)
        let textFieldSpasing = CGFloat(0)
        
        //MARK: - name CONSTRAINTS
        
        let nameTxtFieldConstraints = [
            nameTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            nameTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            nameTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameTextFeild.topAnchor.constraint(equalTo: nameValidationLbl.bottomAnchor)
            
        ]
        
        
        let nameValidationLblConstraints = [
            nameValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            nameValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            nameValidationLbl.leadingAnchor.constraint(equalTo: nameTextFeild.leadingAnchor, constant: 12),
            nameValidationLbl.topAnchor.constraint(equalTo: signUpLbl.bottomAnchor, constant:24),
        ]
        
        //MARK: - MAIL CONSTRAINTS
        
        let mailTxtFieldConstraints = [
            mailTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            mailTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            mailTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mailTextFeild.topAnchor.constraint(equalTo: mailValidationLbl.bottomAnchor, constant: textFieldSpasing)
        ]
        
        let mailValidationLblConstraints = [
            mailValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            mailValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            mailValidationLbl.leadingAnchor.constraint(equalTo: mailTextFeild.leadingAnchor, constant: 12),
            mailValidationLbl.topAnchor.constraint(equalTo: nameTextFeild.bottomAnchor, constant: textFieldSpasing)
        ]
        
        //MARK: - PASSWORD CONSTRAINTS
        
        
        let passwordTextfieldConstraints = [
            passwordTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth - 54),
            passwordTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ]
        let ishiddenBtnConstraints = [
            isHidden.widthAnchor.constraint(equalToConstant: 25),
            isHidden.heightAnchor.constraint(equalToConstant: 20)
        ]
        let passwordStackViewConstraints = [
            passwordStackView.topAnchor.constraint(equalTo: passwordValidationLbl.bottomAnchor),
            passwordStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordStackView.heightAnchor.constraint(equalToConstant: textFieldHeight)
            
        ]
        
        let paswsordValidationLblConstraints = [
            passwordValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            passwordValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            passwordValidationLbl.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor, constant: 12),
            passwordValidationLbl.topAnchor.constraint(equalTo: mailTextFeild.bottomAnchor,constant: textFieldSpasing)
            
        ]
        
        //MARK: - PHONE CONSTRAINTS
        
        let phoneTxtFieldConstraints = [
            phoneTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth),
            phoneTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight),
            phoneTextFeild.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            phoneTextFeild.topAnchor.constraint(equalTo: phoneValidationLbl.bottomAnchor)
            
        ]
        
        
        let phoneValidationLblConstraints = [
            phoneValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            phoneValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            phoneValidationLbl.leadingAnchor.constraint(equalTo: phoneTextFeild.leadingAnchor, constant: 12),
            phoneValidationLbl.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor,constant: textFieldSpasing)
            
        ]
        
        //MARK: - PASSWORD CONFIRMATION CONSTRAINTS
        
        let passwordConfirmationTextfieldConstraints = [
            passwordConfermationTextFeild.widthAnchor.constraint(equalToConstant: textFieldWidth - 54),
            passwordConfermationTextFeild.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ]
        let ishiddenConfirmationBtnConstraints = [
            isConfirmHidden.widthAnchor.constraint(equalToConstant: 25),
            isConfirmHidden.heightAnchor.constraint(equalToConstant: 20)
        ]
        let passwordConfirmationStackViewConstraints = [
            passwordConfirmStackView.topAnchor.constraint(equalTo: passwordConfirmationValidationLbl.bottomAnchor),
            passwordConfirmStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordConfirmStackView.heightAnchor.constraint(equalToConstant: textFieldHeight)
            
        ]
        
        let paswsordConfirmationValidationLblConstraints = [
            passwordConfirmationValidationLbl.widthAnchor.constraint(equalToConstant: textFieldWidth),
            passwordConfirmationValidationLbl.heightAnchor.constraint(equalToConstant: textFieldHeight - 10),
            passwordConfirmationValidationLbl.leadingAnchor.constraint(equalTo: passwordConfirmStackView.leadingAnchor, constant: 12),
            passwordConfirmationValidationLbl.topAnchor.constraint(equalTo: phoneTextFeild.bottomAnchor,constant: textFieldSpasing)
            
        ]
        
        //MARK: - submitBtn CONSTRAINTS
        
        let submitBtnConstraints = [
            signUpBtn.widthAnchor.constraint(equalToConstant: textFieldWidth),
            signUpBtn.heightAnchor.constraint(equalToConstant: textFieldHeight),
            signUpBtn.topAnchor.constraint(equalTo: passwordConfirmStackView.bottomAnchor, constant: 32),
            signUpBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
        ]
        
        
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(signUplblConstraints)
        
        
        NSLayoutConstraint.activate(mailValidationLblConstraints)
        NSLayoutConstraint.activate(mailTxtFieldConstraints)
        
        NSLayoutConstraint.activate(paswsordValidationLblConstraints)
        NSLayoutConstraint.activate(passwordTextfieldConstraints)
        NSLayoutConstraint.activate(ishiddenBtnConstraints)
        NSLayoutConstraint.activate(passwordStackViewConstraints)
        
        NSLayoutConstraint.activate(phoneValidationLblConstraints)
        NSLayoutConstraint.activate(phoneTxtFieldConstraints)
        
        NSLayoutConstraint.activate(paswsordConfirmationValidationLblConstraints)
        NSLayoutConstraint.activate(passwordConfirmationTextfieldConstraints)
        NSLayoutConstraint.activate(ishiddenConfirmationBtnConstraints)
        NSLayoutConstraint.activate(passwordConfirmationStackViewConstraints)
        
        
        NSLayoutConstraint.activate(nameTxtFieldConstraints)
        NSLayoutConstraint.activate(nameValidationLblConstraints)
        
        NSLayoutConstraint.activate(submitBtnConstraints)
        NSLayoutConstraint.activate(submitBtnConstraints)
        
    }
    
    
}






