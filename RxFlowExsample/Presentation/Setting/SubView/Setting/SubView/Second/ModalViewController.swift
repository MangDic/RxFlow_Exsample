//
//  ModalViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/25.
//

import UIKit
import RxSwift
import RxCocoa

class ModalViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    var viewModel: SettingViewModel!
    
    var disposeBag = DisposeBag()
    
    let actionRelay = PublishRelay<SettingActionType>()
    
    lazy var toastView = ModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    private func bind() {
        let _ = viewModel.transform(req: SettingViewModel.Input(actionTrigger: actionRelay.asObservable()))
        toastView.setupDI(observable: actionRelay)
    }

    private func setupLayout() {
        view.addSubview(toastView)
        toastView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
