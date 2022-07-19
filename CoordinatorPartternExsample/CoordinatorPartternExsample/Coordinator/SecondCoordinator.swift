//
//  SecondCoordinator.swift
//  CoordinatorPartternExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit

protocol BackToMainViewControllerDelegate: AnyObject {
    func navigateToMainPage(newOrderCoordinator: SecondCoordinator)
}

class SecondCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: BackToMainViewControllerDelegate?
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewContoller = SecondViewContoller()
        secondViewContoller.delegate = self
        navigationController.pushViewController(secondViewContoller, animated: true)
    }
}

extension SecondCoordinator: SecondViewContollerDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateToMainPage(newOrderCoordinator: self)
    }
    
    func navigateToNextPage() {
        // 다음 뷰가 있다면 그 뷰를 보여주는 코드 작성
    }
}
