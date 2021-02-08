//
//  Category.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

struct ItemCategory: Codable {
    static var categories = [ItemCategory]()

    let id: Int
    let name: String

    static func category(forId categoryId: Int) -> ItemCategory? {
        return categories.first { $0.id == categoryId }
    }
}
