//
//  GameTheme.swift
//  memorize
//
//  Created by Artem Japparov on 30.12.2020.
//

import SwiftUI

class GameTheme: ObservableObject {
    
    @Published var emojiTheme: EmojiThemes
    @Published var background: BackgroundColorTheme
    @Published var rubashkaColor: RubashkaColorTheme
    @Published var gameRules: GameRule<String>
    
    init(
        emojiTheme: EmojiThemes,
        background: BackgroundColorTheme,
        rubashkaColor: RubashkaColorTheme,
        gameRules: GameRule<String>
    ) {
        self.emojiTheme = emojiTheme
        self.background = background
        self.rubashkaColor = rubashkaColor
        self.gameRules = gameRules
    }
    
    static func defaultTheme() -> GameTheme {
        return GameTheme(
            emojiTheme: EmojiThemes(),
            background: BackgroundColorTheme(),
            rubashkaColor: RubashkaColorTheme(),
            gameRules: DefaultGameRule<String>()
        )
    }
}
