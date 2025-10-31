//
//  ConversarionCoordinator.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 31/10/25.
//

import UIKit

final class ConversationCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    private let dependencies: AppDependencies
    private let scenario: ConversationScenario
    
    init(
        navigationController: UINavigationController,
        dependencies: AppDependencies,
        scenario: ConversationScenario
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.scenario = scenario
    }
    
    func start() {
        let viewModel = ConversationViewModel(
            scenario: scenario,
            conversationService: dependencies.conversationService,
            progressService: dependencies.progressService,
            speechRecognizer: dependencies.speechRecognizer,
            speechSynthesizer: dependencies.speechSynthesizer
        )
        
        let viewController = ConversationViewController(viewModel: viewModel)
        viewController.title = scenario.title
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
