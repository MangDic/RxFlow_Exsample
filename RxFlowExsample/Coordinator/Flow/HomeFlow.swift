//
//  HomeFlow.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import RxFlow
import UIKit

class HomeFlow: Flow {
    let rootViewController = UINavigationController(rootViewController: HomeViewController()).then {
        $0.navigationBar.isHidden = true
    }
    
    var root: Presentable {
        return rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .home:
            return setupHomeScreen()
        case .infoRequired:
            return navigateToInfoViewScreen()
        case .back:
            return popupViewController()
        default:
            return .none
        }
    }
    
    private func setupHomeScreen() -> FlowContributors {
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        rootViewController.tabBarItem.title = "홈"
        rootViewController.tabBarItem.image = UIImage(systemName: "house")
        
        return .one(flowContributor: .contribute(withNextPresentable: self.root, withNextStepper: HomeStepper.shared))
    }
    
    private func navigateToInfoViewScreen() -> FlowContributors {
        let vc = InfoViewController()
        rootViewController.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
    
    private func popupViewController() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
}
