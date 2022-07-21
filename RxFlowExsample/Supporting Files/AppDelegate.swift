//
//  AppDelegate.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import UIKit
import RxFlow
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }

        configure(window: window)
        
        let stepper = AppStepper()
        let initFlow = InitFlow()
        
        coordinator.coordinate(flow: initFlow, with: stepper)
        Flows.use(initFlow, when: .created) { root in
            window.backgroundColor = UIColor.white
            window.rootViewController = root
            window.makeKey()
        }
        
        return true
    }
}

extension AppDelegate {
    func configure(window: UIWindow) {
        #if !RELEASE
        coordinatorRxBind()
        #endif
    }

    func coordinatorRxBind() {
//        self.coordinator.rx.willNavigate.subscribe(onNext: { flow, step in
//            Log.d("will navigate to flow=\(flow) and step=\(step)")
//        }).disposed(by: self.disposeBag)

        self.coordinator.rx.didNavigate.subscribe(onNext: { flow, step in
            Log.d("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
    }
}
