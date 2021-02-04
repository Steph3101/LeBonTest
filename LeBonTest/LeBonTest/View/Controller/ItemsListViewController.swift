//
//  ItemsListViewController.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

final class ItemsListViewController: UIViewController {

    let viewModel = ItemsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green

        self.viewModel.fetchItemsAndCategories()
    }
}

extension ItemsListViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
