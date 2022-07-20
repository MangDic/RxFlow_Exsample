//
//  FirstViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/19.
//

import Foundation
import UIKit
import RxSwift

class FirstViewController: UIViewController, ViewModelProtocol {
    typealias ViewModelType = SettingViewModel
    var viewModel: SettingViewModel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: Binding
    private func bind() {
        thirdVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.steps.accept(MainSteps.thirdRequired)
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.viewModel.steps.accept(MainSteps.back)
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    lazy var thirdVCButton = UIButton().then {
        $0.setTitle("Move To ThirdVC", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }
    
    lazy var backButton = UIButton().then {
        $0.setTitle("뒤로가기", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textColor = .white
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(stack)
        
        stack.addArrangedSubview(thirdVCButton)
        stack.addArrangedSubview(backButton)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
    }
}
