//
//  MainCoordinator.swift
//  CoordinatorPartternExsample
//
//  Created by 이명직 on 2022/07/18.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController: MainViewController = MainViewController()
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func navigateToNextPage() {
        let nextCoordinator = SecondCoordinator(navigationController: navigationController)
        nextCoordinator.delegate = self
        childCoordinators.append(nextCoordinator)
        nextCoordinator.start()
    }
}

extension MainCoordinator: BackToMainViewControllerDelegate {
    func navigateToMainPage(newOrderCoordinator: SecondCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
