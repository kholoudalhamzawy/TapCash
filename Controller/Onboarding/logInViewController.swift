//
//  logInViewController.swift
//  TabCash
//
//  Created by KH on 01/05/2023.
//

import UIKit
import Combine

class logInViewController: UIViewController {
   
    
    private var viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let loginLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 32)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.text = "Login"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let welcomeLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.textAlignment = .center
        view.textColor = UIColor(red: 0.588, green: 0.604, blue: 0.627, alpha: 1)
        view.text = "Welcome to Tab cash"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        
        return view
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
    
    
    private let passwordStackView = UIStackView()    

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

    
    private let logInBtn: UIButton = {
        
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapLogIn(){
        viewModel.password = passwordTextFeild.text
        viewModel.email = mailTextFeild.text
        viewModel.validateAuthenticationLogInForm()
    }
    
    
    
    private let alreadyLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 16)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1)
        view.text = "Don't have an account?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signupLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 16)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Sign up", attributes: underlineAttribute)
        view.attributedText = underlineAttributedString
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let signupStackView = UIStackView()

    func configureSignupStackView(){
        signupStackView.addArrangedSubview(alreadyLbl)
        signupStackView.addArrangedSubview(signupLbl)
        
        signupStackView.axis = .horizontal
        signupStackView.distribution = .fillProportionally
        signupStackView.spacing = 6
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(signupStackView)
    }
    
    
    private let rememberMeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
        lbl.text = "Remember me"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let isChecked : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square")?.withTintColor(#colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(togglecheck), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
                     
    @objc func togglecheck( _ sender: UIButton ) {
        let image = sender.currentImage == UIImage(systemName: "square")?.withTintColor(#colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1), renderingMode: .alwaysOriginal) ? UIImage(systemName:"checkmark.square") : UIImage(systemName: "square")
        sender.setImage(image?.withTintColor(#colorLiteral(red: 0.5882352941, green: 0.6039215686, blue: 0.6274509804, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
 }
    
    
    private let rememberMeStackView = UIStackView()
    
    func configureRememberMeStack(){
        rememberMeStackView.addArrangedSubview(isChecked)
        rememberMeStackView.addArrangedSubview(rememberMeLabel)
        
        rememberMeStackView.axis = .horizontal
        rememberMeStackView.distribution = .fillProportionally
        rememberMeStackView.spacing = 8
        rememberMeStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
        
    private let resetPassLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 14)
        view.text = "Forget password?"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    private let forgetRememberPassStackView = UIStackView()
    func configureforgetResetPassStackView(){
        forgetRememberPassStackView.addArrangedSubview(rememberMeStackView)
        forgetRememberPassStackView.addArrangedSubview(resetPassLbl)
        
        forgetRememberPassStackView.axis = .horizontal
        forgetRememberPassStackView.distribution = .fillProportionally
        forgetRememberPassStackView.spacing = 100
        forgetRememberPassStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(forgetRememberPassStackView)
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
    
    private let passwordValidationLbl: UILabel = {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(loginLbl)
        scrollView.addSubview(welcomeLbl)
        scrollView.addSubview(mailValidationLbl)
        scrollView.addSubview(mailTextFeild)
        scrollView.addSubview(passwordValidationLbl)
        configurePasswordStackView()
        configureRememberMeStack()
        configureforgetResetPassStackView()

        scrollView.addSubview(logInBtn)
        configureSignupStackView()
        view.addSubview(errorLbl)

        isModalInPresentation = true //makes the scrollview undissmisable
        
        applyConstarints()
        bindViews()

        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        mailTextFeild.text = "kww@gmail.com"
        passwordTextFeild.text = "kS@123456"
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(DidTapSignUp))
        signupLbl.isUserInteractionEnabled = true
        signupLbl.addGestureRecognizer(tap)


    }
   
    @objc func DidTapSignUp(){
       navigationController?.pushViewController(SignUpViewController(), animated: true)

    }
    
    @objc private func didTapToDismiss(){
        view.endEditing(true)
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
    private func bindViews(){
       
        viewModel.$isAuthenticationFormValid.sink{ [weak self] validationState in
              self?.viewModel.logInUser()
            
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink{ [weak self] user in //when we get a user from the view model
            guard user != nil else {return}
            guard let vc = self?.navigationController?.viewControllers.first as? logInViewController else {return}
            vc.dismiss(animated: true)
        }
        .store(in: &subscriptions)
        
        viewModel.$error.sink{ [weak self] errorString in
            guard let error = errorString else { return } //guard let cause $error is an optional
            self?.errorLbl.text = error
                                
        }
        .store(in: &subscriptions)
        
        viewModel.$emailError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.mailValidationLbl.text = error
        }.store(in: &subscriptions)

        viewModel.$passwordError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.passwordValidationLbl.text = error
        }.store(in: &subscriptions)
    }
   
    
    
    private func applyConstarints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let logoImgViewConstraints = [
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            logoImageView.widthAnchor.constraint(equalToConstant: 146),
            logoImageView.heightAnchor.constraint(equalToConstant: 95),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        let loginlblConstraints = [
            
            loginLbl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            loginLbl.widthAnchor.constraint(equalToConstant: 135),
            loginLbl.heightAnchor.constraint(equalToConstant: 40),
            loginLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ]
        let welcomeLblConstraints = [
            welcomeLbl.widthAnchor.constraint(equalToConstant: 190),
            welcomeLbl.heightAnchor.constraint(equalToConstant: 16),
            welcomeLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            welcomeLbl.topAnchor.constraint(equalTo: loginLbl.bottomAnchor, constant: 16)
        ]
        
        
        let textFieldHeight = CGFloat(48)
        let textFieldWidth = CGFloat(365)
        let textFieldSpasing = CGFloat(2)
        
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
            mailValidationLbl.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: 14),
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
        
       
        let forgetRememberPassStackViewConstraints = [
            forgetRememberPassStackView.topAnchor.constraint(equalTo: passwordTextFeild.bottomAnchor, constant: 12),
            forgetRememberPassStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]

        //MARK: - logInBtn CONSTRAINTS

        let logInBtnConstraints = [
            logInBtn.widthAnchor.constraint(equalToConstant: textFieldWidth),
            logInBtn.heightAnchor.constraint(equalToConstant: textFieldHeight),
            logInBtn.topAnchor.constraint(equalTo: forgetRememberPassStackView.bottomAnchor, constant: 24),
            logInBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

        ]


        let signupStackConstraints = [
            signupStackView.topAnchor.constraint(equalTo: logInBtn.bottomAnchor, constant: 12),
            signupStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let errorLblConstraints = [
           errorLbl.widthAnchor.constraint(equalToConstant: 309),

           errorLbl.heightAnchor.constraint(equalToConstant: 150),
           errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           errorLbl.topAnchor.constraint(equalTo: signupStackView.bottomAnchor, constant: 20)
//           errorLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ]
        
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(logoImgViewConstraints)
        NSLayoutConstraint.activate(loginlblConstraints)
        NSLayoutConstraint.activate(welcomeLblConstraints)
        
        NSLayoutConstraint.activate(mailValidationLblConstraints)
        NSLayoutConstraint.activate(mailTxtFieldConstraints)
        
        NSLayoutConstraint.activate(paswsordValidationLblConstraints)
        NSLayoutConstraint.activate(passwordTextfieldConstraints)
        NSLayoutConstraint.activate(ishiddenBtnConstraints)
        NSLayoutConstraint.activate(passwordStackViewConstraints)

        NSLayoutConstraint.activate(forgetRememberPassStackViewConstraints)
        NSLayoutConstraint.activate(logInBtnConstraints)

        
        NSLayoutConstraint.activate(signupStackConstraints)
       
        NSLayoutConstraint.activate(errorLblConstraints)
    }
        

}
 
