//
//  SettingViewModel.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class SettingViewModel: Stepper, ViewModelType {
    typealias ViewModel = SettingViewModel
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return MainSteps.initialization
    }
    
    func transform(req: Input) -> Output {
        return Output()
    }
}
