//
//  ThirdViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/19.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class ThirdViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = SettingViewModel
    var viewModel: SettingViewModel!
    
    var disposeBag = DisposeBag()
    
    let actionRelay = PublishRelay<SettingActionType>()
    
    lazy var thirdView = ThirdView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: ViewModel Binding
    private func bind() {
        _ = viewModel.transform(req: ViewModel.Input(actionTrigger: actionRelay.asObservable()))
        thirdView.setupDI(observable: actionRelay)
    }
    
    private func setupLayout() {
        view.addSubview(thirdView)
        thirdView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
