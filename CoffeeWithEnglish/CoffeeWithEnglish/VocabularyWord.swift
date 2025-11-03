//
//  VocabularyWord.swift
//  CoffeeWithEnglish
//
//  Created by Rodrigo on 02/11/25.
//
import Foundation

struct VocabularyWord: Identifiable, Equatable {
    let id: UUID
    let term: String
    let ipa: String
    let meaning: String
    let example: String
    let isInformal: Bool
    let tips: String?
    
    init(
        id: UUID = UUID(),
        term: String,
        ipa: String,
        meaning: String,
        example: String,
        isInformal: Bool = false,
        tips: String? = nil
    ){
        self.id = id
        self.term = term
        self.ipa = ipa
        self.meaning = meaning
        self.example = example
        self.isInformal = isInformal
        self.tips = tips
    }
}

struct VocabularySet: Identifiable, Equatable {
    let id: String
    let title: String
    let words: [VocabularyWord]
}
