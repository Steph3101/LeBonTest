//
//  Category.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

struct Category: Codable {
    static var categories = [Category]()

    let id: Int
    let name: String

    static func category(forId categoryId: Int) -> Category? {
        return categories.first { $0.id == categoryId }
    }
}
