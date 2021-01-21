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

struct GameRule<CardContent>: Hashable where CardContent: Comparable {
    
    static func == (lhs: GameRule<CardContent>, rhs: GameRule<CardContent>) -> Bool {
        return lhs.requiredCardsCount == rhs.requiredCardsCount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(requiredCardsCount)
    }
    
    let requiredCardsCount: Int
    private var selectedCards: Array<Card<CardContent>> = []
    
    init(requiredCardsCount: Int) {
        self.requiredCardsCount = requiredCardsCount
    }
    
    mutating func chooseCard(card: Card<CardContent>) -> GameRulesResolution<CardContent> {
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

class EmojiGameRules {
    static let twoCardGameRule = GameRule<String>(requiredCardsCount: 2)
    static let threeCardGameRule = GameRule<String>(requiredCardsCount: 3)
    
    static let allRules = [twoCardGameRule, threeCardGameRule]
}
