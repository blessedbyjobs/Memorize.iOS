//
//  GameRule.swift
//  memorize
//
//  Created by Artem Japparov on 66.66.6666.
//

import Foundation

enum GameRulesResolution {
    case nothing
    case miss(Array<MemoryGame<String>.Card>)
    case hit(Array<MemoryGame<String>.Card>)
}

class GameRule {
    
    let requiredCardsCount: Int
    private var selectedCards: Array<MemoryGame<String>.Card> = []
    
    init(requiredCardsCount: Int) {
        self.requiredCardsCount = requiredCardsCount
    }
    
// первоначально пробовал    func chooseCard(card: MemoryGame<Comparable>.Card) {
    func chooseCard(card: MemoryGame<String>.Card) -> GameRulesResolution {
        var result = GameRulesResolution.nothing
        selectedCards.append(card)
        if selectedCards.count == requiredCardsCount {
            let firstCard = selectedCards.first!
            if selectedCards.allSatisfy({ card in card.content == firstCard.content }) {
                result = .hit(selectedCards)
            } else {
                result = .miss(selectedCards)
            }
            selectedCards = []
        }
        return result
    }
}

class DefaultGameRule: GameRule {
    
    init() {
        super.init(requiredCardsCount: 2)
    }
}
