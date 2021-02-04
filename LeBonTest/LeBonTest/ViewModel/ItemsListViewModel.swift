//
//  ItemsListViewModel.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

protocol ItemsListViewModelDelegate: class {
    func didFetchData()
    func didFailToFetchData()
}

final class ItemsListViewModel {
    private var categories: [Category] = [Category]()
    private var itemsViewModels: [ItemViewModel] = [ItemViewModel]()

    weak var delegate: ItemsListViewModelDelegate?

    var itemsCount: Int {
        return itemsViewModels.count
    }

    func itemViewModel(forItemAtIndex indexPath: IndexPath) -> ItemViewModel {
        return self.itemsViewModels[indexPath.row]
    }

    func fetchItemsAndCategories() {
        APIManager().getCategories { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailToFetchData()
            case .success(let categories):
                self.categories = categories
                print("\(self.categories.count) categories")
                self.fetchItems()
            }
        }
    }

    private func fetchItems() {
        APIManager().getItems { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailToFetchData()
            case .success(let items):
                self.itemsViewModels = items.map({ item -> ItemViewModel in
                    return ItemViewModel(item: item)
                })

                self.delegate?.didFetchData()
                print("\(self.itemsCount) items")
            }
        }
    }
}
