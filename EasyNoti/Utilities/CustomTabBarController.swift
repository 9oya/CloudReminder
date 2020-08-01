//
//  CustomTabBarController.swift
//  EasyNoti
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let homeVC = HomeViewController()
        
        homeVC.title = "Home"
        homeVC.tabBarItem.image = {
            if #available(iOS 13.0, *) {
                let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .regular, scale: .large)
                return UIImage(systemName: "house.fill", withConfiguration: config)
            } else {
                return UIImage(named: "House Fill")
            }
        }()
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        
        viewControllers = [homeNC]
        selectedViewController = homeNC
        selectedIndex = 0
        UITabBar.appearance().tintColor = .systemTeal
        
        let naviBarAppearance = UINavigationBar.appearance()
        naviBarAppearance.tintColor = ColorCompatibility.label
        var image: UIImage!
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .regular, scale: .large)
            image = UIImage(systemName: "arrow.uturn.left", withConfiguration: config)
        } else {
            image = UIImage(named: "Arrow Uturn Left")
        }
        naviBarAppearance.backIndicatorImage = image
        naviBarAppearance.backIndicatorTransitionMaskImage = image
    }
    
    // MARK: UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: HomeViewController.self) {
            // Do something...
        }
        return true
    }
}

