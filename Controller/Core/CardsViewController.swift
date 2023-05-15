//
//  CardsViewController.swift
//  TabCash
//
//  Created by KH on 06/05/2023.
//

import UIKit
import Combine

class CardsViewController: UIViewController {
    
    private var subscriptions: Set<AnyCancellable> = []


    private let cardImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 205))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-card")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let cardNumberCardLbl: UILabel = {
        var view = UILabel(frame: CGRect(x: 0, y: 0, width: 205, height: 17))
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.992, green: 0.992, blue: 0.992, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 24)
        view.attributedText = NSMutableAttributedString(string: "**** **** **** 0329", attributes: [NSAttributedString.Key.kern: 0.48])
        return view
    }()
  
    
    private let nameCardLbl: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 12)
        view.frame = CGRect(x: 0, y: 0, width: 205, height: 17)
        return view
    }()
    private let cardTypeCardLbl: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 14)
        view.text = "Debit"
        view.frame = CGRect(x: 0, y: 0, width: 37, height: 10)

        return view
    }()
    private let expiryCardDateLbl: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 36, height: 8)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 12)
        view.text = "03/25"

        return view
    }()
   
    private let expiryDateLbl: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 121, height: 11)
        view.textColor = UIColor(red: 0.588, green: 0.604, blue: 0.627, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.text = "Expiration date"
        return view
    }()
    
    private let nameLbl: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 162, height: 11)
        view.textColor = UIColor(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 16)
      //  view.text = "MAHMOUD ELSALAKH"

        return view
    }()
    
     private let expiryDateDisplayLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 48, height: 11)
        view.textColor = UIColor(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.text = "03/25"
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    private let cvvLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 35, height: 11)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.588, green: 0.604, blue: 0.627, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.text = "CVV"
        return view
    }()
    

    private let cvvNumberLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 25, height: 11)
        view.textColor = UIColor(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.text = "123"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let todayLbl: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 38, height: 8)
        view.textColor = UIColor(red: 0.588, green: 0.604, blue: 0.627, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 12)
        view.text = "Today"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let line: UIImageView = {
        let line = UIImageView.init(image: UIImage(named:"ic-line"))
        line.contentMode = .scaleToFill
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    func configureNavigationBar(){
      
        let SmartCardView = UILabel()
        SmartCardView.font = UIFont(name: "Poppins-Medium", size: 24)
        SmartCardView.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        SmartCardView.text = "Smart Cards"
        navigationItem.titleView = SmartCardView
                
    }
    
    
     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         configureNavigationBar()
         
         view.addSubview(cardImageView)
         view.addSubview(cardTypeCardLbl)
         view.addSubview(cardNumberCardLbl)
         view.addSubview(cardNumberCardLbl)
         view.addSubview(nameCardLbl)
         view.addSubview(expiryCardDateLbl)
         view.addSubview(todayLbl)
         view.addSubview(nameLbl)
         view.addSubview(line)
         view.addSubview(expiryDateLbl)
         view.addSubview(expiryDateDisplayLbl)
         view.addSubview(cvvLabel)
         view.addSubview(cvvNumberLabel)

         applyConstarints()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViews()
        
    }
    
    private func bindViews(){

        AuthenticationViewViewModel.auth.$name.sink{ [weak self] user in
            guard let user = user else {return}
            self?.nameCardLbl.attributedText = NSMutableAttributedString(string: user, attributes: [NSAttributedString.Key.kern: 1.2])
            self?.nameLbl.text = user
        }
        .store(in: &self.subscriptions)
    }
    
     private func applyConstarints(){
         
         let cardImageViewwConstraints = [
            cardImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
             cardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ]
         let cardTypeCardLblConstraints = [
            cardTypeCardLbl.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 32),
            cardTypeCardLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 24)
         ]
         let cardNumberCardLblConstraints = [
            cardNumberCardLbl.topAnchor.constraint(equalTo: cardTypeCardLbl.bottomAnchor, constant: 80),
            cardNumberCardLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 24)
         ]
         let nameCardLblConstraints = [
            nameCardLbl.topAnchor.constraint(equalTo: cardNumberCardLbl.bottomAnchor, constant: 0),
            nameCardLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 24)
         ]
         let expiryCardDateLblConstraints = [
            expiryCardDateLbl.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -40),
            expiryCardDateLbl.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -45)
         ]
         let todayLblConstraints = [
            todayLbl.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 42),
            todayLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor)
         ]
         let nameLblConstraints = [
            nameLbl.topAnchor.constraint(equalTo: todayLbl.bottomAnchor, constant: 12),
            nameLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor)
         ]
         
         let lineConstraints = [
             line.topAnchor.constraint(equalTo:nameLbl.bottomAnchor, constant: 6),
             line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             line.widthAnchor.constraint(equalToConstant: 400),
             line.heightAnchor.constraint(equalToConstant: 4)
             
         ]
         let expiryDateLblConstraints = [
            expiryDateLbl.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 16),
            expiryDateLbl.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor)
         ]
         let expiryDateDisplayLblConstraints = [
            expiryDateDisplayLbl.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 16),
            expiryDateDisplayLbl.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -4)
         ]
         let cvvLabelConstraints = [
            cvvLabel.topAnchor.constraint(equalTo: expiryDateLbl.bottomAnchor, constant: 16),
            cvvLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor)
         ]
         let cvvNumberLabelConstraints = [
            cvvNumberLabel.topAnchor.constraint(equalTo: expiryDateDisplayLbl.bottomAnchor, constant: 16),
            cvvNumberLabel.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -4)
         ]
         NSLayoutConstraint.activate(cardImageViewwConstraints)
         NSLayoutConstraint.activate(cardTypeCardLblConstraints)
         NSLayoutConstraint.activate(cardNumberCardLblConstraints)
         NSLayoutConstraint.activate(nameCardLblConstraints)
         NSLayoutConstraint.activate(expiryCardDateLblConstraints)
         NSLayoutConstraint.activate(todayLblConstraints)
         NSLayoutConstraint.activate(nameLblConstraints)
         NSLayoutConstraint.activate(lineConstraints)
         NSLayoutConstraint.activate(expiryDateLblConstraints)
         NSLayoutConstraint.activate(expiryDateDisplayLblConstraints)
         NSLayoutConstraint.activate(cvvLabelConstraints)
         NSLayoutConstraint.activate(cvvNumberLabelConstraints)
         
     }
}
