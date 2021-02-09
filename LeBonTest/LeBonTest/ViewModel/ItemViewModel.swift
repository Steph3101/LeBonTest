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
        item.title
    }

    var description: String {
        item.description ?? ""
    }

    var categoryId: Int {
        item.categoryId
    }

    var category: String? {
        ItemCategory.category(forId: self.item.categoryId)?.name ?? ""
    }

    var price: String {
        Tools.currencyFormatter.string(from: NSNumber(value: item.price)) ?? ""
    }

    var smallImageUrl: URL? {
        item.imagesUrl?.small
    }

    var thumbImageUrl: URL? {
        item.imagesUrl?.thumb
    }

    var isUrgent: Bool {
        item.isUrgent == true
    }

    var creationDate: Date {
        item.creationDate
    }

    var readableDate: String {
        "Publié le \(Tools.dateFormatter.string(from: self.item.creationDate))"
    }
}
