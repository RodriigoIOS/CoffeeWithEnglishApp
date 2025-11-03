//
//  ConversationViewController.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import UIKit
import Combine

final class ConversationViewController: UIViewController {
    
    // MARK: Propriedades
    
    private let viewModel: ConversationViewModel
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var customView: ConversationView = {
        let view = ConversationView()
        return view
    }()
    
    // Subjects
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let sendMessageSubject = PassthroughSubject<String, Never>()
    private let toggleVoiceModeSubject = PassthroughSubject<Void, Never>()
    private let startListeningSubject = PassthroughSubject<Void, Never>()
    private let stopListeningSubject = PassthroughSubject<Void, Never>()
    private let speakMessageSubject = PassthroughSubject<String, Never>()
    
    // Data
    private var messages: [Message] = []
    
    // Inicializacao
    init(viewModel: ConversationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupActions()
        bindViewModel()
        viewDidLoadSubject.send()
        
    }
    
    //MARK: Private Methods
    
    private func setupTableView() {
        
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        
    }
    
    private func setupActions() {
        
        customView.voiceModeButton.addTarget(self, action: #selector(voiceModeButtonTapped), for: .touchUpInside)
        customView.microphoneButton.addTarget(self, action: #selector(microphoneButtonTapped), for: .touchUpInside)
        customView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        customView.inputTextField.delegate = self
        
    }
    
    private func bindViewModel() {
        let input = ConversationViewModel. Input(
            viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
            sendMessage: sendMessageSubject.eraseToAnyPublisher(),
            toggleVoiceMode: toggleVoiceModeSubject.eraseToAnyPublisher(),
            startListening: startListeningSubject.eraseToAnyPublisher(),
            stopListening: stopListeningSubject.eraseToAnyPublisher(),
            speakMessage: speakMessageSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        
        //bind messages
        output.messages
            .receive(on: DispatchQueue.main)
            .sink{[weak self] messages in
                self.messages = messages
                self.customView.tableView.reloadData()
                self.scrollToBottom()
            }
            .store(in: &cancellables)
        
        //bind voice mode
        output.voiceMode
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isEnabled in
                self.customView.updateVoiceMode(isEnabled)
            }
            .store(in: &cancellables)
        
        // bind listening state
        output.isListening
            .Receive(on: DispatchQueue.main)
            .sink {[weak self] isListening in
                self.customView.updateListeningState(isListening)
            }
            .store(in: &cancellables)
        
        //bind recognized text
        output.recognizedText
            .receive(on: DispatchQueue.main)
            .sink {[weak self] text in
                self.customView.inputTextField.text = text
            }
            .store(in: &cancellables)
        
        
    }
    
    private func scrollToBottom() {
        guard messages.count > 0 else {return}
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        customView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @objc private func voiceModeButtonTapped() {
        toggleVoiceModeSubject.send()
    }
    
    @objc private func microphoneButtonTapped() {
        startListeningSubject.send()
    }
    
    @objc private func sendButtonTapped() {
        guard let text  = customView.inputTextField.text, !text.isEmpty else {return}
        
        sendMessageSubject.send(text)
        customView.inputTextField.text = ""
    }
}

extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
}

extension ConversationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
}
