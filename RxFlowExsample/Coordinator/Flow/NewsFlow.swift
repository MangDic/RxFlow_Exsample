//
//  NewsFlow.swift
//  RxFlowExsample
//
//  Created by 이명직 on 2022/07/27.
//

import Foundation
import RxFlow
import UIKit

class NewsFlow: Flow {
    lazy var rootViewController = UINavigationController().then { $0.isNavigationBarHidden = true }
    
    var root: Presentable {
        return rootViewController
    }
    
    private let service = NewsService()
    
    private var viewModel: NewsViewModel!
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .newsRequired:
            return setupNewsScreen()
        default:
            return .none
        }
    }
    
    private func setupNewsScreen() -> FlowContributors {
        viewModel = NewsViewModel(with: service)
        
        rootViewController.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")
        rootViewController.tabBarItem.title = "뉴스"
        rootViewController.tabBarItem.image = UIImage(systemName: "newspaper")
        
        return FlowSugar(viewModel, NewsViewController.self)
            .oneStepPushBy(self.rootViewController)
    }
}
