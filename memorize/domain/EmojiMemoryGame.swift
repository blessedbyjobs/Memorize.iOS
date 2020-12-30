//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

class EmojiMemoryGame {
    
    private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // intents
    
    func chooseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
