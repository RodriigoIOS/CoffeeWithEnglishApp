//
//  ReadingMaterial.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import Foundation

struct ReadingQuestion: Identifiable, Equatable {
    let id: UUID
    let question: String
    let options: [String]
    let correctIndex: Int
    
    init(
        id: UUID = UUID(),
        question: String,
        options: [String],
        correctIndex: Int
    ){
        self.id = id
        self.question = question
        self.options = options
        self.correctIndex = correctIndex
    }
}

struct ReadingMaterial: Identifiable, Equatable {
    let id: String
    let title: String
    let level: String
    let text: String
    let questions: [ReadingQuestion]
}
