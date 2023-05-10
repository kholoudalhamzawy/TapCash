//
//  MainTabbarViewController.swift
//  TabCash
//
//  Created by KH on 01/05/2023.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: CardsViewController())
        let vc3 = UINavigationController(rootViewController: TransferViewController())
        let vc4 = UINavigationController(rootViewController: HistoryViewController())
        let vc5 = UINavigationController(rootViewController: kidsAccountsViewController())


        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.tabBarItem.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "creditcard")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "creditcard.fill")
        vc2.tabBarItem.title = "Cards"
        
        vc3.tabBarItem.image = UIImage(named: "ic-transfer")
        vc3.tabBarItem.title = "Transfer"

        vc4.tabBarItem.image = UIImage(systemName: "clock")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "clock.fill")
        vc4.tabBarItem.title = "History"

        vc5.tabBarItem.image = UIImage(named: "ic-baby")
        vc5.tabBarItem.title = "Kids"

        
        setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: true)
    }
    

}

