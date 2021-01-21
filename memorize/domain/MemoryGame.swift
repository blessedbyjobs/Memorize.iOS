//
//  MemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Comparable {
    
    let hitPrize: Int = 2
    let missPenalty = 1
    
    var cards: Array<Card<CardContent>> = Array()
    var gameRules: GameRule<CardContent>
    
    var isGameOver: Bool {
        cards.allSatisfy { card in
            card.isMatched
        }
    }
    
    var score: Int = 0
    
    init(gameRules: GameRule<CardContent>) {
        self.gameRules = gameRules
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter {cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
                }
            }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(card: Card<CardContent>) -> GameRulesResolution<CardContent> {
        print("picked card \(card)")
        let chosenIndex = cards.firstIndex(matching: card)!
        let result = gameRules.chooseCard(card: cards[chosenIndex])
        cards[chosenIndex].isJustSeen = false
        cards[chosenIndex].isFaceUp = true
        return result
    }
    
    mutating func applyResult(result: GameRulesResolution<CardContent>) {
        switch result {
            case .miss(let missedCards):
                missedCards.forEach { card in
                    score -= card.isSeenBefore ? missPenalty : 0
                    let choosenIndex = cards.firstIndex(matching: card)!
                    cards[choosenIndex].isJustSeen = true
                    cards[choosenIndex].isSeenBefore = true
                    cards[choosenIndex].isFaceUp = false
                }
            case .hit(let hittedCards): do {
                score += hitPrize
                hittedCards.forEach { card in
                    let choosenIndex = cards.firstIndex(matching: card)!
                    cards[choosenIndex].isMatched = true
                    cards[choosenIndex].isJustSeen = true
                    cards[choosenIndex].isFaceUp = true
                }
            }
            default: do {
                // nothing to do
            }
        }
    }
    
    mutating func buildCard(content: CardContent, id: Int? = nil) {
        cards.append(Card(content: content, id: id ?? cards.count ))
    }
    
    mutating func clearModel() {
        clearCards()
        clearScore()
    }
    
    private mutating func clearCards() {
        cards.removeAll()
    }
    
    private mutating func clearScore() {
        score = 0
    }
}

struct Card<CardContent>: Identifiable where CardContent: Comparable {
    var isFaceUp: Bool
    var isMatched: Bool
    var content: CardContent
    var isSeenBefore: Bool
    var isJustSeen: Bool
    var id: Int
            
    init(content: CardContent, id: Int) {
        self.content = content
        isFaceUp = false
        isMatched = false
        isSeenBefore = false
        isJustSeen = false
        self.id = id
    }
}
