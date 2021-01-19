//
//  Theme.swift
//  memorize
//
//  Created by Artem Japparov on 17.01.2021.
//

import Foundation

struct Theme: Hashable {
    let name: String
    let emojiTheme: EmojiTheme
    let background: ColorTheme
    let rubashkaColor: ColorTheme
}

enum GameThemes: CaseIterable {
    case HALLOWEEN
    case DEVICES
    case FRUITS
    
    func getTheme() -> Theme {
        switch self {
        case .HALLOWEEN:
            return Theme(
                name: "Halloween",
                emojiTheme: EmojiThemes.themes.first!,
                background: Colors.sapphire,
                rubashkaColor: Colors.pumpkin
            )
        case .DEVICES:
            return Theme(
                name: "Devices",
                emojiTheme: EmojiThemes.themes[1],
                background: Colors.concrete,
                rubashkaColor: Colors.blackPearl
            )
        case .FRUITS:
            return Theme(
                name: "Fruits",
                emojiTheme: EmojiThemes.themes.last!,
                background: Colors.yougurt,
                rubashkaColor: Colors.redApple
            )
    }
    }
}
