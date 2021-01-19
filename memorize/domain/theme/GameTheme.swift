//
//  GameTheme.swift
//  memorize
//
//  Created by Artem Japparov on 30.12.2020.
//

import SwiftUI

class GameTheme: ObservableObject {
    
    @Published var gameTheme: GameThemes
    
    var background: ColorTheme {
        gameTheme.getTheme().background
    }
    var rubashkaColor: ColorTheme {
        gameTheme.getTheme().rubashkaColor
    }
    var pie: Int = 0 /// todo!!!
    
    init(
        gameTheme: GameThemes
    ) {
        self.gameTheme = gameTheme
        
    }
    
    static func defaultTheme() -> GameTheme {
        return GameTheme(gameTheme: GameThemes.HALLOWEEN)
    }
}
