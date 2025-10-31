//
//  AppCoordinator.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 30/10/25.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    private let dependencies: AppDependencies
    
    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(
            navigationController: navigationController,
            dependencies: dependencies
        )
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}

