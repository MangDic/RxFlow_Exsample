//
//  FirstViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/19.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class FirstViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    var viewModel: SettingViewModel!
    
    var disposeBag = DisposeBag()
    
    let actionRelay = PublishRelay<SettingActionType>()
    
    lazy var firstView = FirstView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: ViewModel Binding
    private func bind() {
        _ = viewModel.transform(req: ViewModel.Input(actionTrigger: actionRelay.asObservable()))
        firstView.setupDI(observable: actionRelay)
    }
    
    private func setupLayout() {
        view.addSubview(firstView)
        firstView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
