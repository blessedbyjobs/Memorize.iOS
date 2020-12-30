//
//  MemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

struct MemoryGame <CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("picked card \(card)")
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}

