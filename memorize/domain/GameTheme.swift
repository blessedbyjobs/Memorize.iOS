//
//  GameTheme.swift
//  memorize
//
//  Created by Artem Japparov on 30.12.2020.
//

import Foundation

struct GameTheme {
    
    // MARK: - Properties
       
       private var theme: String = "FRUITS"
       private var themeLabels: Array<String>
       
       
       init() {
           themeLabels = Array(themes.keys)
       }

       // MARK: - Public methods
       
       func getTheme() -> String {
           return themes[theme]!
       }
       
       mutating func getTheme(at position: Int) -> String {
           self.theme = themeLabels[position % themeLabels.count]
           return self.getTheme()
       }
       
       mutating func getRandTheme() -> String {
           let position = themeLabels.count.random
           return getTheme(at: position)
       }
       
       func getTheme(theme tempTheme: String) -> String? {
           return themes[tempTheme]
       }

       // MARK: - Private methods
       
       private var themes: Dictionary<String, String> = [
           "FRUITS":  "🍏🍎🍐🍊🍋🍌🍉🍇🍑🍒🍈🍓🍍🥝",
           "FACES": "😀😄😁😆😂😊☺️😉🙂",
           "ANIMALS": "🐶🐱🐼🐻🦊🐰🐮🐷🐵🐤🦆🦉🐴",
           "WEATHER": "⚡️🌪🌈☀️⛅️☁️🌦🌧🌩❄️💨☔️🌊",
           "SPORTS": "⚽️🏀🏈🎾🏐🏓🏒⛸🥊🥋",
           "COMPUTERS": "💻🖥⌨️🖱🕹💽💾📼📟📠📱"
       ]
}
