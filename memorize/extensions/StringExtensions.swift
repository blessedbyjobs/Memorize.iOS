//
//  StringExtensions.swift
//  memorize
//
//  Created by Artem Japparov on 02.01.2021.
//

import Foundation

extension String {
    
    func letterize() -> [String] {
        return self.map { String($0) }
    }

    
    func at(_ index: Int) -> String {
        // хоспади, спаси раба божия да сниспошли решение попроще
        return self.letterize()[index]
    }
    
    func sliceRandomUniqueValues(count: Int = 1) -> String {
        if self.count < count {
            return self
        }
        var resultSet = Set<String>()
        while resultSet.count < count {
            let randomIndex = self.count.random
            resultSet.insert(self.at(randomIndex))
        }
        return resultSet.joined()
    }
}

extension Character {
    
    func toString() -> String {
        return "\(self)"
    }
}
