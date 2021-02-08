//
//  ItemsListViewModelTests.swift
//  LeBonTestTests
//
//  Created by Stéphane Azzopardi on 08/02/2021.
//

import XCTest
@testable import LeBonTest

class ItemsListViewModelTests: XCTestCase {
    var itemsListViewModel: ItemsListViewModel!

    func loadStub(name: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: "json")

        return try! Data(contentsOf: url!)
    }

    override func setUpWithError() throws {
        let itemsData = loadStub(name: "listing")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let items = try! decoder.decode([Item].self, from: itemsData)

        self.itemsListViewModel = ItemsListViewModel(items: items)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterItems() {
        let vehicleCategory = ItemCategory(id: 1, name: "Véhicule")

        itemsListViewModel.filterItems(forCategory: vehicleCategory)
        for itemVM in self.itemsListViewModel.itemsViewModels {
            XCTAssertTrue(itemVM.categoryId == vehicleCategory.id)
        }

        let homeCategory = ItemCategory(id: 4, name: "Maison")
        itemsListViewModel.filterItems(forCategory: homeCategory)
        XCTAssertTrue(self.itemsListViewModel.itemsCount == 76)
    }

    func testPerformanceExample() throws {
        self.measure {
            itemsListViewModel.filterItems(forCategory: ItemCategory(id: 1, name: ""))
        }
    }

}
