//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = MemoryGame(gameRules: EmojiGameRules.twoCardGameRule)
    
    //MARK: - public fields
    var cards: Array<Card<String>> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var gameMode: GameRule<String> {
        model.gameRules
    }
    
    init() {
        newGame()
    }
    
    private func generateCards(with emoji: String, number: Int) {
        number.times {
            model.buildCard(content: emoji)
        }
    }
    
    //MARK: - intents
    
    func chooseCard(card: Card<String>) {
        let result = model.choose(card: card)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.model.applyResult(result: result)
        })
    }
    
    func updateRules(rule: GameRule<String>) {
        model.gameRules = rule
        newGame()
    }
    
    func newGame() {
        model.clearModel()
        Int.random(in: 2...5)
            .times { index in
                generateCards(with: "\(index)", number: model.gameRules.requiredCardsCount)
        }
    
        shuffle()
    }
    
    func shuffle() {
        model.shuffle()
    }
}
