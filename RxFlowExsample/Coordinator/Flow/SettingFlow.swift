//
//  SettingFlow.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxFlow

class SettingFlow: Flow {
    lazy var rootViewController = UINavigationController().then { $0.isNavigationBarHidden = true }
    
    var root: Presentable {
        return self.rootViewController
    }
    
    var viewModel = SettingViewModel()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .setting:
            return setSettingScreen()
        case .firstRequired:
            return navigateToFirstScreen()
        case .thirdRequired:
            return navigateToThirdScreen()
        case .modalRequired:
            return navigateToModalScreen()
        case .back:
            return popViewController()
        case .dismiss:
            return dismiss()
        default:
            return .none
        }
    }
    
    private func setSettingScreen() -> FlowContributors {
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        rootViewController.tabBarItem.title = "설정"
        rootViewController.tabBarItem.image = UIImage(systemName: "gearshape")
        
        return FlowSugar(viewModel, SettingViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToFirstScreen() -> FlowContributors {
        MainTabBarContoller.shared.tabBar.isHidden = true
        
        return FlowSugar(viewModel, FirstViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToThirdScreen() -> FlowContributors {
        MainTabBarContoller.shared.tabBar.isHidden = true
        return FlowSugar(viewModel, ThirdViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func popViewController() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
    
    private func navigateToModalScreen() -> FlowContributors {
        return FlowSugar(viewModel, ModalViewController.self)
            .oneStepPopoverPresent(self.rootViewController)
    }
    
    private func dismiss() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }
}
