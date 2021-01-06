//
//  ViewExtensions.swift
//  memorize
//
//  Created by Artem Japparov on 06.01.2021.
//

import SwiftUI

extension View {
    func foregroundColor(_ color: ColorThemes) -> some View {
        return self.foregroundColor(color.currentColor)
    }
}


extension Shape {
    func fill(_ color: ColorThemes) -> some View {
        return self.fill(color.currentColor)
    }
}
