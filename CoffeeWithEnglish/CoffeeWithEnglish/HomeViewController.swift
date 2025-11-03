//
//  HomeViewController.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 31/10/25.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    // MARK: - Propriedades
    
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    weak var coordinator: HomeCoordinatorDelegate?
    
    private lazy var customView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    // Subjects for input
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let scenarioTappedSubject = PassthroughSubject<ConversationScenario, Never>()
    private let vocabularyTappedSubject = PassthroughSubject<VocabularySet, Never>()
    private let pronunciationTappedSubject = PassthroughSubject<PronunciationExercise, Never>()
    private let grammarTappedSubject = PassthroughSubject<GrammarTopic, Never>()
    private let readingTappedSubject = PassthroughSubject<ReadingMaterial, Never>()
    
    // Data sources
    private var scenarios: [ConversationScenario] = []
    private var vocabularySets: [VocabularySet] = []
    private var pronunciationExercises: [PronunciationExercise] = []
    private var grammarTopics: [GrammarTopic] = []
    private var readingMaterials: [ReadingMaterial] = []
    
    
    //Initialization
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Ciclo de vida
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "English Agent"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
        bindViewModel()
        viewDidLoadSubject.send()
    }
    
    //Private Methods
    
    private func setupCollectionview() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView?.register(Activity.self, forCellWithReuseIdentifier: ActivityCell.identifier)
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
            scenarioTapped: scenarioTappedSubject.eraseToAnyPublisher(),
            vocabularyTapped: vocabularyTappedSubject.eraseToAnyPublisher(),
            pronunciationTapped: pronunciationTappedSubject.eraseToAnyPublisher(),
            grammarTapped: grammarTappedSubject.eraseToAnyPublisher(),
            readingTapped: readingTappedSubject.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input: input)
        
        //Bind progress
        output.progress
            .receive(on: DispatchQueue.main)
            .sink { [weak self] progress in
                self?.customView.progressView.configure(with: progress)
            }
            .store(in: &cancellables)
        
        //Bind scenarios
        output.scenarios
            .receive(on: DispatchQueue.main)
            .sink { [weak self] scenarios in
                self.scenarios = scenarios
                self?.customView.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        //Bind VocabularySets
        output.vocabularySets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sets in
                self.vocabularySets = sets
            }
            .store(in: &cancellables)
        
        //bind Pronunciation exercises
        output.pronunciationExercises
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exercises in
                self?.pronunciationExercises = exercises
            }
            .store(in: &cancellables)
        
        //bind navigation
        output.navigateToConversation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] scenario in
                guard let self = self, let coordinator = self.coordinator else {return}
                coordinator.homeCoordinatorDidSelectScenario(coordinator as! HomeCoordinator, scenario: scenario)
            }
            .store(in: &cancellables)
        
        //bind errors
        output.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCell.identifier, for: indexPath) as? UIActivityCell else {
            return UICollectionViewCell()
        }
        
        let scenario = scenarios[indexPath.item]
        cell.configure(with: scenario)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenarios.count
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scenario = scenarios[indexPath.item]
        scenarioTappedSubject.send(scenario)
    }
}
