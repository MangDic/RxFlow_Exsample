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
    
    var viewModel: SettingViewModel
    
    init(settingViewModel: SettingViewModel) {
        self.viewModel = settingViewModel
        
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        rootViewController.tabBarItem.title = "설정"
        rootViewController.tabBarItem.image = UIImage(systemName: "gearshape")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .setting:
            return setSettingScreen()
        case .firstRequired:
            return navigateToFirstScreen()
        case .secondRequired:
            return navigateToSecondScreen()
        case .thirdRequired:
            return navigateToThirdScreen()
        case .back:
            return popupViewController()
        default:
            return .none
        }
    }
    
    private func setSettingScreen() -> FlowContributors {
        return FlowSugar(viewModel, SettingViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToFirstScreen() -> FlowContributors {
        MainTabBarContoller.shared.tabBar.isHidden = true
        
        return FlowSugar(viewModel, FirstViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToSecondScreen() -> FlowContributors {
        MainTabBarContoller.shared.tabBar.isHidden = true
        return FlowSugar(viewModel, SecondViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToThirdScreen() -> FlowContributors {
        MainTabBarContoller.shared.tabBar.isHidden = true
        return FlowSugar(viewModel, ThirdViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
    
    private func popupViewController() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        if rootViewController.viewControllers.count == 1 {
            MainTabBarContoller.shared.tabBar.isHidden = false
        }
        return .none
    }
}
