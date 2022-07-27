//
//  NewsViewController.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/27.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class NewsViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = NewsViewModel
    
    var viewModel: NewsViewModel!
    
    let requestTregger = PublishRelay<Void>()
    
    lazy var newsView = NewsView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
        
        requestTregger.accept(())
    }
    
    fileprivate func setupLayout() {
        view.addSubview(newsView)
        
        newsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Binding
    fileprivate func bind() {
        let req = viewModel.transform(req: ViewModel.Input.init(requestTrigger: requestTregger))
        
        newsView.setupDI(relay: req.newsRelay)
    }
}
