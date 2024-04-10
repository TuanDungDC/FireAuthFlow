//
//  TabBarViewController.swift
//  FireAuthFlow
//
//  Created by Nguyễn Tuấn Dũng on 05/04/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x0B / 255.0, green: 0x0F / 255.0, blue: 0x2F / 255.0, alpha: 1)
        setUpTab()
    }
    
    private func setUpTab() {
        let homeVC = HomeViewController()
        
        let na1VC = UINavigationController(rootViewController: homeVC)
        
        na1VC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = .gray // Màu cho icon khi không được chọn
            self.tabBar.tintColor = .white // Màu cho icon khi được chọn
        } else {
            // Fallback trên các phiên bản iOS cũ hơn
            UITabBar.appearance().tintColor = .white
        }
        
        setViewControllers([na1VC], animated: true)
    }

}

