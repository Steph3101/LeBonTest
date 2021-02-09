//
//  ItemViewModel.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

struct ItemViewModel {

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
    }()

    private let item: Item

    init(item: Item) {
        self.item = item
    }

    var title: String {
        return self.item.title
    }

    var description: String {
        return self.item.description ?? ""
    }

    var categoryId: Int {
        return self.item.categoryId
    }

    var category: String? {
        return ItemCategory.category(forId: self.item.categoryId)?.name ?? ""
    }

    var price: String {
        return Tools.currencyFormatter.string(from: NSNumber(value: self.item.price)) ?? ""
    }

    var smallImageUrl: URL? {
        return self.item.imagesUrl?.small
    }

    var thumbImageUrl: URL? {
        return self.item.imagesUrl?.thumb
    }

    var isUrgent: Bool {
        return self.item.isUrgent == true
    }

    var creationDate: Date {
        return self.item.creationDate
    }

    var readableDate: String {
        return Tools.dateFormatter.string(from: self.item.creationDate)
    }
}
