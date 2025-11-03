//
//  ActivityCell.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 01/11/25.
//

import UIKit

final class ActivityCell: UICollectionViewCell {
    static let identifier = "ActivityCell"
    
    //Componentes de interface
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Inicializacao
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with scenario: ConversationScenario) {
        titleLabel.text = scenario.title
        levelLabel.text = scenario.level.rawValue.capitalized
        
        switch scenario.level {
        case .formal:
            contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        case .informal:
            contentView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        }
    }
}

// MARK: - ViewCodeProtocol

extension ActivityCell: ViewCodeProtocol {
    //Continnuar codando o protocol
    
    func setupViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(levelLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            levelLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
