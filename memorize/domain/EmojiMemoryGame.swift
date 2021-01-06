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
    var cards: Array<Card<String>> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }

    private (set) var gameTheme: GameTheme
    
    init(gameTheme: GameTheme) {
        self.gameTheme = gameTheme
        gameTheme.emojiTheme.currentTheme
            .sliceRandomUniqueValues(count: 4)  // готовим 4 случайных элемента стрки с выбранной темой
            .map{ char in "\(char)" }           // преобразовываем char в строку
            .forEach { emoji in
                generateCards(with: emoji, number: gameTheme.gameRules.requiredCardsCount)
            }
    }
    
    private func generateCards(with emoji: String, number: Int) {
        number.times {
            model.buildCard(content: emoji)
        }
    }
    
    //MARK: - intents
    
    func chooseCard(card: Card<String>) {
        model.choose(card: card)
    }
}
