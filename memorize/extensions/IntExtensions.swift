//
//  IntExtensions.swift
//  memorize
//
//  Created by Artem Japparov on 30.12.2020.
//

import Foundation

extension Int {
    
    var random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
