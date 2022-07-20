//
//  FirstViewFlow.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/20.
//

import Foundation
import RxFlow
import UIKit

class FirstViewFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UIViewController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .initialization:
            return .none
        default:
            return .none
        }
    }
}
