//
//  ItemsListViewModel.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import Foundation

protocol ItemsListViewModelDelegate: class {
    func didUpdateItems()
    func didFailToFetchItems()
}

final class ItemsListViewModel {

    private var items: [Item] {
        didSet {
            self.itemsViewModels = self.items.map({ item -> ItemViewModel in
                return ItemViewModel(item: item)
            })
        }
    }

    var categories: [ItemCategory] {
        return ItemCategory.categories
    }

    var itemsViewModels: [ItemViewModel] = [ItemViewModel]() {
        didSet {
            self.delegate?.didUpdateItems()
        }
    }

    weak var delegate: ItemsListViewModelDelegate?

    var itemsCount: Int {
        return itemsViewModels.count
    }

    var isFilteringEnable: Bool {
        return self.itemsCount > 0
    }

    init(items: [Item] = [Item]()) {
        self.items = items
    }

    func itemViewModel(forItemAtIndex indexPath: IndexPath) -> ItemViewModel {
        return self.itemsViewModels[indexPath.row]
    }

    func fetchItemsAndCategories() {
        APIManager.shared.getCategories { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailToFetchItems()
            case .success(let categories):
                ItemCategory.categories = categories
                self.fetchItems()
            }
        }
    }

    private func fetchItems() {
        APIManager.shared.getItems { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.items.removeAll()
                self.delegate?.didFailToFetchItems()
            case .success(let items):
                self.items = self.sort(items)
                print("\(ItemCategory.categories.count) categories - \(self.itemsCount) items")
            }
        }
    }

    func filterItems(forCategory category: ItemCategory) {
        self.itemsViewModels = self.items.filter({ item -> Bool in
            return item.categoryId == category.id
        }).map({ItemViewModel(item: $0)})
    }

    func resetFilter() {
        self.itemsViewModels = items.map({ ItemViewModel(item: $0) })
    }

    // Order items by date and urgent first
    func sort(_ items: [Item]) -> [Item] {
        let urgentItems = items.filter({ $0.isUrgent })
        let nonUrgentItems = items.filter({ !$0.isUrgent })

        var sortedItems = urgentItems.sorted { (firstItem, secondItem) -> Bool in
            return firstItem.creationDate.compare(secondItem.creationDate) == ComparisonResult.orderedDescending
        }

        sortedItems.append(contentsOf: nonUrgentItems.sorted { (firstItem, secondItem) -> Bool in
            return firstItem.creationDate.compare(secondItem.creationDate) == ComparisonResult.orderedDescending
        })

        return sortedItems
    }
}
