//
//  ItemsListViewModel.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

final class ItemsListViewModel {
    var categories: [Category] = [Category]()
    var itemsViewModels: [ItemViewModel] = [ItemViewModel]()

    var itemsCount: Int {
        return itemsViewModels.count
    }

    func fetchItemsAndCategories() {
        APIManager().getCategories { result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let categories):
                self.categories = categories
                self.fetchItems()
            }
        }
    }

    private func fetchItems() {
        APIManager().getItems { result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let items):
                self.itemsViewModels = items.map({ item -> ItemViewModel in
                    return ItemViewModel(item: item)
                })

                print("\(self.itemsCount) items")
            }
        }
    }
}
