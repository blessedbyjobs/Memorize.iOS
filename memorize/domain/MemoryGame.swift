//
//  MemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Comparable {
    var cards: Array<Card<CardContent>> = Array()
    var gameRules: GameRule<CardContent> = DefaultGameRule()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter {cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
                }
            }
    }
    
    mutating func choose(card: Card<CardContent>) {
        print("picked card \(card)")
        let chosenIndex = cards.firstIndex(matching: card)!
        let result = gameRules.chooseCard(card: cards[chosenIndex])
        cards[chosenIndex].isFaceUp = true
        switch result {
        case .miss(let missedCards):
            missedCards.forEach { card in
                let choosenIndex = cards.firstIndex(matching: card)!
                cards[choosenIndex].isFaceUp = true
            }
        case .hit(let hittedCards):
            hittedCards.forEach { card in
                let choosenIndex = cards.firstIndex(matching: card)!
                cards[choosenIndex].isMatched = true
                cards[choosenIndex].isFaceUp = true
            }
        default: do {
            // nothing to do
        }
        }
        
//        if let chosenIndex = cards.firstIndex(matching: card),
//           !cards[chosenIndex].isFaceUp,
//           !cards[chosenIndex].isMatched {
//            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                    cards[chosenIndex].isMatched = true
//                    cards[potentialMatchIndex].isMatched = true
//                }
//                cards[chosenIndex].isFaceUp = true
//            } else {
//                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
//            }
//        }

    }
    
    mutating func buildCard(content: CardContent, id: Int? = nil) {
        cards.append(Card(content: content, id: id ?? cards.count ))
    }
}

struct Card<CardContent>: Identifiable where CardContent: Comparable {
    var isFaceUp: Bool
    var isMatched: Bool
    var content: CardContent
    var id: Int
            
    init(content: CardContent, id: Int) {
        self.content = content
        isFaceUp = false
        isMatched = false
        self.id = id
    }
}
