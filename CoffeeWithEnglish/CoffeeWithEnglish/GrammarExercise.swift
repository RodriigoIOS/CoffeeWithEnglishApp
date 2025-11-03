//
//  GrammarExercise.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import Foundation

struct GrammarQuestion: Identifiable, Equatable {
    let id: UUID
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    
    init(
        id: UUID = UUID(),
        question: String,
        options: [String],
        correctIndex: Int,
        explanation: String
    ){
        self.id = id
        self.question = question
        self.options = options
        self.correctIndex = correctIndex
        self.explanation = explanation
    }
}

struct GrammarTopic: Identifiable, Equatable {
    let id: String
    let title: String
    let explanation: String
    let exercises: [GrammarQuestion]
}
