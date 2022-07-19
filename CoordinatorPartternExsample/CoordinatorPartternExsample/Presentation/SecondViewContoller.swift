//
//  SecondViewContoller.swift
//  CoordinatorPartternExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SecondViewContollerDelegate: AnyObject {
    func navigateToMainPage()
    func navigateToNextPage()
}

class SecondViewContoller: UIViewController {
    var disposeBag = DisposeBag()
    
    public weak var delegate: SecondViewContollerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: Binding
    private func bind() {
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.delegate?.navigateToMainPage()
            }).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var label = UILabel().then {
        $0.text = "Second ViewController"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        $0.textAlignment = .center
    }
    
    lazy var button = UIButton().then {
        $0.setTitle("Move To Main Screen", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 4
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.snp.makeConstraints { $0.center.equalToSuperview() }
        
        button.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 300, height: 40))
            $0.top.equalTo(label.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
    }
}
