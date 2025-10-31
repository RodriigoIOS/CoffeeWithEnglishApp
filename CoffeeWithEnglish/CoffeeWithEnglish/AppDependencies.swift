//
//  AppDependencies.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 31/10/25.
//

import Foundation

// Container de injecao de dependecia seguindo os principios do SOLID

struct AppDependencies {
    let storage: StorageProtocol
    let progressService: ProgressServiceProtocol
    let conversationService: ConversationServiceProtocol
    let contentProvider: ContentProviderProtocol
    let speechRecognizer: SpeechRecognizerProtocol
    let speechSynthesizer: SpeechSynthesizerProtocol
    
    static func makeDefault() -> AppDependencies {
        let storage = UserDefaultsStorage()
        let progressService = ProgressService(storage: storage)
        let conversationService = ConversationService()
        let contentProvider = ContentProvider()
        let speechRecognizer = SpeechRecognizer()
        let speechSynthesizer = SpeechSynthesizer()
        
        return AppDependencies(
            storate: storage,
            progressService: progressService,
            conversationService: conversationService,
            contentProvider: contentProvider,
            speechRecognizer: speechRecognizer,
            speechSynthesizer: speechSynthesizer
        )
    }
}
