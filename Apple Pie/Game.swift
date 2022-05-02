//
//  Game.swift
//  Apple Pie
//
//  Created by Jeffrey on 23/03/2021.
//

import Foundation

struct Game {
    static var totalWins = 0 
    static var totalLosses = 0
    static let incorrectMovesAllowed = 7

    var incorrectMovesRemaining: Int = Game.incorrectMovesAllowed

    static let listOfWords = ["dog", "cat", "banana", "pen", "chalk", "case", "bell", "tomato", "car", "dad", "airpods"]
    static var currentListOfWords = Game.listOfWords
    
    var word: String
    private var guessedLetters: Array<Character> = []
    
    init?() {
        guard Game.currentListOfWords.count > 0 else { return nil }
        word = Game.currentListOfWords.removeFirst()
    }
    
    mutating func getformattedWord(withSpaces: Bool) -> String {
        let transform = {  guessedLetters.contains($0) ? "\($0)" : "_" }
        let guessedWord = word.map(transform).joined(separator: withSpaces ? " " : "")
        
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
