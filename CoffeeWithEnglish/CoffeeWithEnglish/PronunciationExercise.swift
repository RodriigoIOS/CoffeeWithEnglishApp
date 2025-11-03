//
//  PronunciationExercise.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//

import Foundation

struct PronunciationWord: Identifiable, Equatable {
    let id: UUID
    let word: String
    let ipa: String
    let tip: String
    let example: String
    
    init(
        id: UUID = UUID(),
        word: String,
        ipa: String,
        tip: String,
        example: String
    ) {
        self.id = id
        self.word = word
        self.ipa = ipa
        self.tip = tip
        self.example = example
    }
}

struct PronunciationExercise: Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let exercises: [PronunciationWord]
}
