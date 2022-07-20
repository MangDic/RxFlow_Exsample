//
//  SettingViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift

class SettingViewController: UIViewController, ViewModelProtocol {
    typealias ViewModelType = SettingViewModel
    
    var viewModel: ViewModelType!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupLayout()
        bind()
    }
    
    private func bind() {
        firstVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.viewModel.steps.accept(MainSteps.firstRequired)
            }).disposed(by: disposeBag)
        
        secondVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.viewModel.steps.accept(MainSteps.secondRequired)
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    lazy var firstVCButton = UIButton().then {
        $0.setTitle("Move To FirstVC", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }
    
    lazy var secondVCButton = UIButton().then {
        $0.setTitle("Move To SecondVC", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(stack)
        
        stack.addArrangedSubview(firstVCButton)
        stack.addArrangedSubview(secondVCButton)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
    }
}
