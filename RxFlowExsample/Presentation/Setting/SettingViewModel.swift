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

/// Setting Flow내의 뷰에서 발생할 수 있는 이벤트를 정의합니다.
enum SettingActionType {
    case nextScreen(step: MainSteps)
    case previousScreen(step: MainSteps)
}

class SettingViewModel: Stepper, ViewModelType {
    typealias ViewModel = SettingViewModel
    
    struct Input {
        let actionTrigger: Observable<SettingActionType>
    }
    
    struct Output {
        /// 뷰로 보내줄 데이터가 있을 경우 Relay 추가
    }
    
    var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return MainSteps.initialization
    }
    /// 액션 트리거를 바인딩 해줍니다. (이벤트가 발생한다 -> 해당 이벤트의 액션 타입을 actionTrigger에 넣어준다 -> 액션 타입에 맞는 동작을 수행한다(runAction))
    func transform(req: Input) -> Output {
        req.actionTrigger.bind(onNext: runAction).disposed(by: disposeBag)
        return Output()
    }
}

extension SettingViewModel {
    /// 각 Setting Action에 맞게 로직을 처리하도록 연결해주는 메소드
    private func runAction(_ actionType: SettingActionType) {
        switch actionType {
        case .nextScreen(let step):
            moveToNextPage(step: step)
        case .previousScreen(let step):
            moveToPreviousPage(step: step)
        }
    }
    
    private func moveToNextPage(step: MainSteps) {
        steps.accept(step)
    }
    
    private func moveToPreviousPage(step: MainSteps) {
        steps.accept(step)
    }
}
