//
//  ColorTheme.swift
//  memorize
//
//  Created by Artem Japparov on 31.12.2020.
//

import SwiftUI

class ColorThemes: ObservableObject {
    
    // MARK: - Public properties
    @Published var currentColor: ColorTheme
    
    // MARK: - Private properties
    
    internal var colors: Array<ColorTheme> = [.white]
    
    internal init(colors: Array<ColorTheme>) {
        self.colors = colors
        currentColor = colors.first ?? .white
    }
}

struct ColorTheme: Identifiable, Hashable {
    let name: String
    let color: Color
    let id: String
    
    init(name: String, color: Color) {
        self.id = name
        self.name = name
        self.color = color
    }
    
    static let white = ColorTheme(name: "white", color: .white)
}

class BackgroundColorTheme: ColorThemes {
    
    init() {
        super.init(colors: [
            ColorTheme(
                name: "sapphire",
                color: Color.init(red: 0.02, green: 0.23, blue: 0.39)
            ),
            ColorTheme(
                name: "black pearl",
                color: Color.init(red: 0.09, green: 0.11, blue: 0.13)
            )
        ])
    }
}

class RubashkaColorTheme: ColorThemes {
    
    init() {
        super.init(colors: [
            ColorTheme(
                name: "pumpkin",
                color: Color.init(red: 1, green: 0.46, blue: 0.09)
            ),
            ColorTheme(
                name: "concrete",
                color: Color.init(red: 0.85, green: 0.85, blue: 0.84)
            )
        ])
    }
}

