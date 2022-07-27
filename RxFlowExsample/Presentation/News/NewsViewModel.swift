//
//  NewsViewModel.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/27.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

class NewsViewModel: Stepper, ViewModelType {
    typealias ViewModel = NewsViewModel
    
    var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    let newsRelay = BehaviorRelay<[NewsInfo]>(value: [])
    
    var service: NewsService!
    
    init(with: NewsService) {
        self.service = with
    }
    
    struct Input {
        let requestTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let newsRelay: BehaviorRelay<[NewsInfo]>
    }
    
    func transform(req: Input) -> Output{
        service.newsRelay.bind(to: newsRelay).disposed(by: disposeBag)
        
        return NewsViewModel.Output(newsRelay: newsRelay)
    }
}
