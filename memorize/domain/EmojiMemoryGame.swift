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
    
    init() {
        newGame()
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
    
    func newGame() {
        model.clearCards()
        (0...4).map { index in
            "\(index)"
        }.forEach { index in
            generateCards(with: index, number: 2)
        }
        
//        gameTheme.gameTheme.getTheme().emojiTheme.content
//            .sliceRandomUniqueValues(count: 4)  // готовим 4 случайных элемента стрки с выбранной темой
//            .map{ char in "\(char)" }           // преобразовываем char в строку
//            .forEach { emoji in
//                generateCards(with: emoji, number: 2)
//            }
        shuffle()
    }
    
    func shuffle() {
        model.shuffle()
    }
}
