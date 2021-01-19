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

class Colors: ColorThemes {
    
    static let sapphire = ColorTheme(
        name: "sapphire",
        color: Color.init(red: 0.02, green: 0.23, blue: 0.39)
    )
    
    static let blackPearl = ColorTheme(
        name: "black pearl",
        color: Color.init(red: 0.09, green: 0.11, blue: 0.13)
    )
    
    static let pumpkin = ColorTheme(
        name: "pumpkin",
        color: Color.init(red: 1, green: 0.46, blue: 0.09)
    )
    
    static let concrete = ColorTheme(
        name: "concrete",
        color: Color.init(red: 0.85, green: 0.85, blue: 0.84)
    )
    
    static let yougurt = ColorTheme(
        name: "yougurt",
        color: Color.init(red: 0.96, green: 0.88, blue: 0.88)
    )
    
    static let redApple = ColorTheme(
        name: "redApple",
        color: Color.init(red: 0.59, green: 0.09, blue: 0.08)
    )
    
    
    init() {
        super.init(colors: [Self.pumpkin, Self.concrete, Self.blackPearl, Self.sapphire])
    }
}

