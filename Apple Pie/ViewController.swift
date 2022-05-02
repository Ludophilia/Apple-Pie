//
//  ViewController.swift
//  Apple Pie
//
//  Created by Jeffrey on 17/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var restartGameButton: UIButton!
    
    // MARK: Setup
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if let newGame = Game() {
            self.currentGame = newGame
            enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
            restartGameButton.isHidden = false
        }
        updateUI()
    }
    
    // MARK: Refresh

    func updateUI() {
        scoreLabel.text = "Wins: \(Game.totalWins), Losses: \(Game.totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        correctWordLabel.text = currentGame.getformattedWord(withSpaces: true)
    }
    
    func enableLetterButtons(_ value: Bool) {
        letterButtons.forEach({ $0.isEnabled = value })
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            Game.totalLosses += 1
            newRound()
        } else if currentGame.word == currentGame.getformattedWord(withSpaces: false) {
            Game.totalWins += 1
            newRound()
        } else {
            updateUI()
        }
    }
    
    // MARK: Buttons

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        if let letterString = sender.title(for: .normal) {
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateGameState()
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartGameButton.isHidden = true
        Game.currentListOfWords = Game.listOfWords
        newRound()
    }
}
