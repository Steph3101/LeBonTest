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

    var name: String {
        return String(item.id)
    }
}
