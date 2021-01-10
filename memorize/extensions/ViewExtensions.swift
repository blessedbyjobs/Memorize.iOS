//
//  ViewExtensions.swift
//  memorize
//
//  Created by Artem Japparov on 06.01.2021.
//

import SwiftUI

extension View {
    func foregroundColor(_ themes: ColorThemes) -> some View {
        return self.foregroundColor(themes.currentColor)
    }
    
    func foregroundColor(_ theme: ColorTheme) -> some View {
        return self.foregroundColor(theme.color)
    }
    
    func background(_ color: ColorThemes) -> some View {
        return self.background(color.currentColor.color)
    }
}


extension Shape {
    func fill(_ themes: ColorThemes) -> some View {
        return self.fill(themes.currentColor)
    }
    
    func fill(_ theme: ColorTheme) -> some View {
        return self.fill(theme.color)
    }

}
