//
//  GameRule.swift
//  memorize
//
//  Created by Artem Japparov on 66.66.6666.
//

import Foundation

enum GameRulesResolution<CardContent> where CardContent: Comparable {
    case nothing
    case miss(Array<Card<CardContent>>)
    case hit(Array<Card<CardContent>>)
}

class GameRule<CardContent> where CardContent: Comparable {
    
    let requiredCardsCount: Int
    private var selectedCards: Array<Card<CardContent>> = []
    
    init(requiredCardsCount: Int) {
        self.requiredCardsCount = requiredCardsCount
    }
    
    func chooseCard(card: Card<CardContent>) -> GameRulesResolution<CardContent> {
        var result = GameRulesResolution<CardContent>.nothing
        if !card.isFaceUp && !card.isMatched {
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
        }
        return result
    }
}

class DefaultGameRule<CardContent>: GameRule<CardContent> where CardContent: Comparable {
    
    init() {
        super.init(requiredCardsCount: 3)
    }
}
