//
//  SettingViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class SettingViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    
    var viewModel: ViewModel!
    
    var disposeBag = DisposeBag()
    var actionTrigger = PublishRelay<SettingActionType>()
    
    lazy var settingView = SettingView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupLayout()
        bind()
    }
    
    // MARK: ViewModel Binding
    private func bind() {
        _ = viewModel.transform(req: ViewModel.Input(actionTrigger: actionTrigger.asObservable()))
        
        settingView.setupDI(observable: actionTrigger)
    }
    
    private func setupLayout() {
        view.addSubview(settingView)
        
        settingView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
