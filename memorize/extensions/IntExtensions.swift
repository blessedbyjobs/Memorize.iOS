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
    
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
    
    func times(_ f: (Int) -> ()) {
        if self > 0 {
            for i in 0..<self {
                f(i)
            }
        }
    }

}
