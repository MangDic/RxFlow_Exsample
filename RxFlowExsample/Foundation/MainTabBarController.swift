//
//  MainTabBarController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/27.
//

import Foundation
import UIKit

class MainTabBarContoller: UITabBarController {
    static let shared = MainTabBarContoller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
        /// UIVisualEffectBackdropView 제거
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8695364594, green: 0.8643680215, blue: 0.8735097051, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
}
