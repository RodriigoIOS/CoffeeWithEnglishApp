//
//  UserProgress.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import Foundation

struct UserProgress: Codable, Equatable {
    
    var totalSessions: Int
    var streak: Int
    var vocabularyLearned: Int
    var conversationCompleted: Int
    var pronunciationPracticed: Int
    var lastPractice: Date?
    
    init(
        totalSessions: Int = 0,
        streak: Int = 0,
        vocabularyLearned: Int = 0,
        conversationCompleted: Int = 0,
        pronunciationPracticed: Int = 0,
        lastPractice: Date? = nil
    ) {
        self.totalSessions = totalSessions
        self.streak = streak
        self.vocabularyLearned = vocabularyLearned
        self.conversationCompleted = conversationCompleted
        self.pronunciationPracticed = pronunciationPracticed
        self.lastPractice = lastPractice
    }
}
