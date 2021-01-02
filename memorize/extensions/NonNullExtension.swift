//
//  NonNullExtenstion.swift
//  memorize
//
//  Created by Artem Japparov on 31.12.2020.
//

import Foundation

extension Optional where Wrapped == Int {

    var nonNull: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == String {

    var nonNull: String {
        return self ?? ""
    }
}
