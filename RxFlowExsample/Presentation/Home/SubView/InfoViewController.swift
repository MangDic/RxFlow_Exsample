//
//  InfoViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift

class InfoViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    private func bind() {
        backButton.rx.tap
            .subscribe(onNext: {
                HomeStepper.shared.steps.accept(MainSteps.back)
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var titleLabel = UILabel().then {
        $0.text = "Info"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textAlignment = .center
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
        
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        
        titleLabel.snp.makeConstraints { $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide) }
        
        backButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 150, height: 40))
        }
    }
}
