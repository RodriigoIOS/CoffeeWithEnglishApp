//
//  HomeCoordinator.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 30/10/25.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func HomeCoordinatorDidSelectScenario(_ coordinator: HomeCoordinator, scenario: ConversationScenario)
    func HomeCoordinatorDidSelectVocabulary(_ coordinator: HomeCoordinator, set: VocabularySet)
    func HomeCoordinatorDidSelectPronunciation(_ coordinator: HomeCoordinator, scenario: PronunciationExercise)
    func HomeCoordinatorDidSelectGrammar(_ coordinator: HomeCoordinator, scenario: GrammarTopic)
    func HomeCoordinatorDidSelectReading(_ coordinator: HomeCoordinator, scenario: ReadingMaterial)
}

final class HomeCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    private let dependencies: AppDependencies
    
    init(navigationController: UINavigationController, dependencies: AppDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewModel = HomeViewModel(
            progressService: dependencies.progressService,
            contentProvider: dependencies.contentProvider
        )
        
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func HomeCoordinatorDidSelectScenario(_ coordinator: HomeCoordinator, scenario: ConversationScenario) {
        let conversationCoordinator = ConversationCoordinator(
            navigationController: navigationController,
            dependencies: dependencies,
            scenario: scenario
        )
        
        childCoordinators.append(conversationCoordinator)
        conversationCoordinator.start()
    }
    
    func HomeCoordinatorDidSelectVocabulary(_ coordinator: HomeCoordinator, set: VocabularySet) {
        //
    }
    
    func HomeCoordinatorDidSelectPronunciation(_ coordinator: HomeCoordinator, scenario: PronunciationExercise) {
        //
    }
    
    func HomeCoordinatorDidSelectGrammar(_ coordinator: HomeCoordinator, scenario: GrammarTopic) {
        //
    }
    
    func HomeCoordinatorDidSelectReading(_ coordinator: HomeCoordinator, scenario: ReadingMaterial) {
        //
    }
}
