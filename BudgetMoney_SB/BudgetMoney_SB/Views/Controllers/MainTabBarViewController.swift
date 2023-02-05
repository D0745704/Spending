//
//  MainTabBarViewController.swift
//  BudgetMoney_SB
//
//  Created by 仲輝 on 2022/12/2.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .label
        
        let vc1 = UINavigationController(rootViewController: TargetViewController())
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        
        if #available(iOS 14, *) {
            vc1.tabBarItem.image = UIImage(systemName: "target")
        } else {
            vc1.tabBarItem.image = UIImage(systemName: "ellipsis.circle")
        }
        
        if #available(iOS 16, *) {
            vc2.tabBarItem.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        } else {
            vc2.tabBarItem.image = UIImage(systemName: "cart")
        }
        
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        self.selectedIndex = 1
    }
    

}
