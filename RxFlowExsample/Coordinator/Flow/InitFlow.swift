//
//  InitFlow.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import RxFlow
import UIKit

class InitFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = MainTabBarContoller.shared
    
    private let homeFlow = HomeFlow()
    private let settingFlow = SettingFlow()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .initialization:
            return setupTabBar()
        default:
            return .none
        }
    }
    
    private func setupTabBar() -> FlowContributors {
        rootViewController.tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rootViewController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8695364594, green: 0.8643680215, blue: 0.8735097051, alpha: 1)
        rootViewController.tabBar.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    
        /// setup Home ViewController
        HomeFlow.shared.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        HomeFlow.shared.tabBarItem.title = "홈"
        HomeFlow.shared.tabBarItem.image = UIImage(systemName: "house")
        
        /// setup Message ViewController
        let flows: [Flow] = [homeFlow, settingFlow]
        
        Flows.use(flows, when: .ready, block: { [weak self] root in
            guard let `self` = self else { return }
            self.rootViewController.viewControllers = root
        })
        
        return .multiple(flowContributors:
                            [FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: HomeStepper.shared),
                             FlowContributor.contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: MainSteps.setting))])
    }
}
