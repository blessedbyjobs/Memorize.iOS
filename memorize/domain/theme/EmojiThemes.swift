//
//  EmojiThemes.swift
//  memorize
//
//  Created by Artem Japparov on 31.12.2020.
//

import Foundation

class EmojiThemes: ObservableObject {
    
    // MARK: - Properties
    
    @Published var currentTheme: EmojiTheme
    
    static let themes: Array<EmojiTheme> = [
        EmojiTheme(name: "halloween", content:  "👻🎃🧞‍♂️🧟‍♂️🧙🏻‍♂️🧝🧛🏻‍♂️💀"),
        EmojiTheme(name: "devices", content: "💻🖥⌨️🖱🕹💽💾📼📟📠📱"),
        EmojiTheme(name: "fruits", content:  "🍏🍎🍐🍊🍋🍌🍉🍇🍑🍒🍈🍓🍍🥝")
    ]
    
    // MARK: - Public methods
    
    init() {
        currentTheme = Self.themes.first!
    }
    
    func getRandTheme() -> EmojiTheme {
        let position = Self.themes.count.random
        return Self.themes[position]
    }
}


struct EmojiTheme: Identifiable, Hashable {
    let id: String
    let name: String
    let content: String
    
    init(name: String, content: String) {
        self.id = name
        self.name = name
        self.content = content
    }

    static let empty: EmojiTheme = EmojiTheme(name: "", content: "")
}
