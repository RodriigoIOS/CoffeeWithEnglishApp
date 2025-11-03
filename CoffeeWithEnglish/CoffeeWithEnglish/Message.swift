//
//  Message.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import Foundation

struct Message: Identifiable, Equatable {
    
    let id: UUID
    let role: MessageRole
    let text: String
    let context: ConversationLevel?
    let feedback: String?
    let timestamp: Date
    
    init(
        id: UUID = UUID(),
        role: MessageRole,
        text: String,
        context: ConversationLevel?  = nil,
        feedback: String? = nil,
        timestamp: Date = Date()
    ){
        self.id = id
        self.role = role
        self.text = text
        self.context = context
        self.feedback = feedback
        self.timestamp = timestamp
    }
}

enum MessageRole: String, Codable {
    case user
    case agent
}
