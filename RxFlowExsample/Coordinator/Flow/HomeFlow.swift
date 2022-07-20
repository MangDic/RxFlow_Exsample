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
    static let shared = UINavigationController(rootViewController: HomeViewController()).then { $0.isNavigationBarHidden = true }
    
    var root: Presentable {
        return HomeFlow.shared
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .infoRequired:
            return navigateToInfoViewScreen()
        case .back:
            return popupViewController()
        default:
            return .none
        }
    }
    
    private func setupHomeScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(withNextPresentable: HomeFlow.shared, withNextStepper: HomeStepper.shared))
    }
    
    private func navigateToInfoViewScreen() -> FlowContributors {
        let vc = InfoViewController()
        HomeFlow.shared.pushViewController(vc, animated: true)
        MainTabBarContoller.shared.tabBar.isHidden = true
        return .none
    }
    
    private func popupViewController() -> FlowContributors {
        HomeFlow.shared.popToRootViewController(animated: true)
        if HomeFlow.shared.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
}
