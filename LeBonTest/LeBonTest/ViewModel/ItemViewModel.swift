//
//  ItemViewModel.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

struct ItemViewModel {
    private let item: Item

    init(item: Item) {
        self.item = item
    }

    var title: String {
        return item.title ?? ""
    }

    var category: String {
        guard let categoryId = self.item.categoryId else { return "" }
        return Category.category(forId: categoryId)?.name ?? ""
    }

    var price: String {
        guard let price = item.price else { return "" }
        return Tools.currencyFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
