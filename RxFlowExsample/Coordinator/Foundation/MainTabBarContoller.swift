//
//  MainTabBarContoller.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit

class MainTabBarContoller: UITabBarController {
    static let shared = MainTabBarContoller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
        
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "message")
        firstVC.tabBarItem.title = "Recent"
        firstVC.tabBarItem.image = UIImage(systemName: "message.fill")
        
        viewControllers = [firstVC]
    }
}
