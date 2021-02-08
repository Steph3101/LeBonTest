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
        return item.title
    }

    var categoryId: Int {
        return self.item.categoryId
    }

    var category: String? {
        return ItemCategory.category(forId: self.item.categoryId)?.name ?? ""
    }

    var price: String {
        return Tools.currencyFormatter.string(from: NSNumber(value: item.price)) ?? ""
    }

    var smallImageUrl: URL? {
        return item.imagesUrl?.small
    }

    var thumbImageUrl: URL? {
        return item.imagesUrl?.thumb
    }

    var isUrgent: Bool {
        return item.isUrgent == true
    }

    var creationDate: Date {
        return item.creationDate
    }
}
