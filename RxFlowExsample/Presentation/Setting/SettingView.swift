//
//  SettingView.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/21.
//

import UIKit
import RxSwift
import RxRelay

class SettingView: UIView {
    var disposeBag = DisposeBag()
    let actionRelay = PublishRelay<SettingActionType>()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Dependency Injection
    func setupDI(observable: PublishRelay<SettingActionType>) {
        actionRelay.bind(to: observable).disposed(by: disposeBag)
    }
    
    // MARK: Binding
    private func bind() {
        firstVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.actionRelay.accept(.nextScreen(step: .firstRequired))
            }).disposed(by: disposeBag)
        
        secondVCButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.actionRelay.accept(.nextScreen(step: .secondRequired))
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var titleLabel = UILabel().then {
        $0.text = "Setting"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
    }
    
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
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(stack)
        
        stack.addArrangedSubview(firstVCButton)
        stack.addArrangedSubview(secondVCButton)
        
        titleLabel.snp.makeConstraints { $0.top.leading.trailing.equalTo(safeAreaLayoutGuide) }
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
    }
}
