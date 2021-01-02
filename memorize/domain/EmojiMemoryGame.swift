//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Artem Japparov on 29.12.2020.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = MemoryGame()
    
    //MARK: - public fields
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    private (set) var gameTheme: GameTheme
    
    init(gameTheme: GameTheme) {
        self.gameTheme = gameTheme
        model.buildCard(content: "1")
        model.buildCard(content: "2")
        model.buildCard(content: "2")
        model.buildCard(content: "1")
    }
    
    //MARK: - intents
    
    func chooseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
