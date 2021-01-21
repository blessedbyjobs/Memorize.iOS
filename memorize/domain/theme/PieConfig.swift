//
//  PieConfig.swift
//  memorize
//
//  Created by Artem Japparov on 21.01.2021.
//

import Foundation

struct PieConfig: Equatable, Hashable {
    let startAngle: Double
    let endAngle: Double
    let opacity: Double
    
    static let defaultConfing = PieConfig(
        startAngle: 0-90,
        endAngle: 100-90,
        opacity: 0.4
    )
    
    static let pacmanConfing = PieConfig(
        startAngle: -25,
        endAngle: 25,
        opacity: 0.5
    )
    
    static let diskConfing = PieConfig(
        startAngle: -1,
        endAngle: 0,
        opacity: 0.3
    )
}
