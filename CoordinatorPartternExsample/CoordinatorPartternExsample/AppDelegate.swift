//
//  AppDelegate.swift
//  CoordinatorPartternExsample
//
//  Created by 이명직 on 2022/07/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }
        window.rootViewController = UINavigationController()
        
        mainCoordinator = MainCoordinator(navigationController: window.rootViewController! as! UINavigationController)
        mainCoordinator?.start()
        
        window.backgroundColor = .white
        window.makeKeyAndVisible()

        return true
    }
}

