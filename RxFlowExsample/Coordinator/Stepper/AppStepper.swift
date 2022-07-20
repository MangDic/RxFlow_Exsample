//
//  AppStepper.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

class AppStepper: Stepper {
    static let shared = AppStepper()
    
    var steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return MainSteps.initialization
    }
}
