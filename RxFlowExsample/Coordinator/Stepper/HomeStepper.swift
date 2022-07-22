//
//  HomeStepper.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import RxFlow
import RxCocoa

class HomeStepper: Stepper {
    static let shared = HomeStepper()
    
    var steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return MainSteps.home
    }
}
