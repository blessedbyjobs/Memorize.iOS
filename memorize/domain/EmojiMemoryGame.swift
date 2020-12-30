//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = MemoryGame()
    
    init() {
        model.buildCard(content: "1")
        model.buildCard(content: "2")
        model.buildCard(content: "3")
        model.buildCard(content: "4")
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // intents
    
    func chooseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
