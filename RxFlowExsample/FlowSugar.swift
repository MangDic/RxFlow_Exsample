//
//  FlowSugar.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/20.
//

import RxFlow
import UIKit

typealias ViewModelStepper = ViewModelType & Stepper
typealias ViewModelController = ViewModelProtocol & UIViewController

class FlowSugar<VM, VC>: NSObject where VM: ViewModelStepper, VC: ViewModelController {
    var vm: VM!
    var vc: VC?
    
    init(_ vm: VM, _ vc: VC.Type) {
        self.vm = vm
        self.vc = VC().then {
            $0.viewModel = vm as? VC.ViewModelType
        }
        super.init()
    }
    
    func oneStepPushBy(_ navi: UINavigationController, isHideBottombar: Bool = false, includeOpaqueBar: Bool = false, animation: Bool = true) -> FlowContributors {
        if let vc = self.vc {
            vc.hidesBottomBarWhenPushed = isHideBottombar
            vc.extendedLayoutIncludesOpaqueBars = includeOpaqueBar
            navi.pushViewController(vc, animated: animation)
            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
        }
        return .none
    }
}
