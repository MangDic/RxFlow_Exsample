//
//  Coordinator.swift
//  CoordinatorPartternExsample
//
//  Created by 이명직 on 2022/07/18.
//

import UIKit

protocol Coordinator {
    /// 자식 Coordinator를 담는 배열
    var childCoordinators: [Coordinator] { get set }
    
    /// init 대신 var navigationController: UINavigationController  { get set } 으로 구현하셔도 됩니다!
    init(navigationController: UINavigationController)
    
    func start()
}

