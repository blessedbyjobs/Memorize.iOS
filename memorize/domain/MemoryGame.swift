//
//  MemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

struct MemoryGame <CardContent> {
    var cards: Array<Card> = Array()
    
    func choose(card: Card) {
        print("picked card \(card)")
    }
    
    mutating func buildCard(content: CardContent, id: Int? = nil) {
        cards.append(Card(content: content, id: id ?? cards.count ))
    }
    
    struct Card: Identifiable {
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
}

