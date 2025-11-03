//
//  ConversationScenario.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

struct ConversationScenario: Identifiable, Equatable {
    let id: String
    let title: String
    let level: ConversationLevel
    let context:String
    let starter: String
}

enum ConversationLevel: String, Codable {
    case formal
    case informal
}
