//
//  GameTheme.swift
//  memorize
//
//  Created by Artem Japparov on 30.12.2020.
//

import UIKit

struct GameTheme {
    
    let emojiTheme: EmojiThemes
    let background: BackgroundColorTheme
    let rubashkaColor: RubashkaColorTheme
    
    static func defaultTheme() -> GameTheme {
        let emojis = EmojiThemes()
        let backgroundTheme = BackgroundColorTheme()
        let rubashkaTheme = RubashkaColorTheme()
        return GameTheme(
            emojiTheme: emojis,
            background: backgroundTheme,
            rubashkaColor: rubashkaTheme
        )
    }
}
