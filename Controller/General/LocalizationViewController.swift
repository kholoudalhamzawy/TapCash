//
//  LocalizationViewController.swift
//  TabCash
//
//  Created by KH on 03/05/2023.
//

import UIKit

class LocalizationViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let EnBtn: UIButton = {
        
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.titleLabel?.font = UIFont(name: "Inter-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1), for: .normal)
        btn.setTitle("English", for: .normal)
//        btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let ArBtn: UIButton = {
        
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.titleLabel?.font = UIFont(name: "Inter-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("عربي", for: .normal)
//        btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let btnStackView = UIStackView()

    func configurebtnStackView(){
        
        btnStackView.addArrangedSubview(EnBtn)
        btnStackView.addArrangedSubview(ArBtn)
        
        btnStackView.axis = .horizontal
        btnStackView.distribution = .fillProportionally
        btnStackView.spacing = 44
        btnStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(btnStackView)
        configurebtnStackView()
        applyConstarints()
    }
    
    private func applyConstarints(){
        
     
        let logoImgViewConstraints = [
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 309),
            logoImageView.widthAnchor.constraint(equalToConstant: 295),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let ArBtnConstraints = [
            ArBtn.widthAnchor.constraint(equalToConstant: 125),
            ArBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let EnBtnConstraints = [
            EnBtn.widthAnchor.constraint(equalToConstant: 125),
            EnBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let BtnStackConstraint = [
            btnStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 76)
        ]
        
        NSLayoutConstraint.activate(logoImgViewConstraints)
        NSLayoutConstraint.activate(ArBtnConstraints)
        NSLayoutConstraint.activate(EnBtnConstraints)
        NSLayoutConstraint.activate(BtnStackConstraint)


    }

}
