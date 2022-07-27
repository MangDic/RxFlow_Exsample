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
    private let newsFlow = NewsFlow()
    
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
        /// setup Message ViewController
        let flows: [Flow] = [homeFlow, settingFlow, newsFlow]
        
        Flows.use(flows, when: .ready, block: { [weak self] root in
            guard let `self` = self else { return }
            self.rootViewController.viewControllers = root
        })
        return .multiple(flowContributors:
                            [FlowContributor.contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: MainSteps.home)),
                             FlowContributor.contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: MainSteps.setting)), FlowContributor.contribute(withNextPresentable: newsFlow, withNextStepper: OneStepper(withSingleStep: MainSteps.newsRequired))])
    }
}
