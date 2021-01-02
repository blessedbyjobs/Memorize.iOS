//
//  ColorTheme.swift
//  memorize
//
//  Created by Artem Japparov on 31.12.2020.
//

import SwiftUI

class ColorThemes {
    
    // MARK: - Public properties
    var currentColor: Color {
        return colors[colorIndex]
    }
    
    // MARK: - Private properties
       
    private var colorIndex: Int = 0
    internal var colors: Array<Color> = [.white]
       
    
    internal init(colors: Array<Color>) {
        self.colors = colors
    }
}

class BackgroundColorTheme: ColorThemes {
    
    init() {
        super.init(colors: [
            Color.init(red: 0.02, green: 0.23, blue: 0.39),
            Color.init(red: 0.09, green: 0.11, blue: 0.13)
        ])
    }
}

class RubashkaColorTheme: ColorThemes {
    
    init() {
        super.init(colors: [
            Color.init(red: 1, green: 0.46, blue: 0.09),
            Color.init(red: 0.85, green: 0.85, blue: 0.84)
        ])
    }
}

