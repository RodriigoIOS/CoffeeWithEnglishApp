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
    
    // Setar propriedades do projeto ainda na ViewControllerPrincipal.
}
