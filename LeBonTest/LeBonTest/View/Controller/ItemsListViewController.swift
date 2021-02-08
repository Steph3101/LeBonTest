//
//  ItemsListViewController.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

protocol ItemsListViewControllerDelegate: class {
    func didSelect(itemViewModel: ItemViewModel)
}

final class ItemsListViewController: UIViewController {

    let viewModel = ItemsListViewModel()
    weak var delegate: ItemsListViewControllerDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()

    private lazy var filterButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "filter"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.filterButtonPressed))

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        self.viewModel.delegate = self
        self.viewModel.fetchItemsAndCategories()
        self.title = "LeBonTest"
    }

    @objc private func filterButtonPressed() {
        let alert = UIAlertController(title: "Filtrer par catégorie",
                                      message: nil,
                                      preferredStyle: .actionSheet)

        for category in self.viewModel.categories {
            alert.addAction(UIAlertAction(title: category.name, style: .default) { action in
                print("Category selected : \(category.id)")
                self.viewModel.filterItems(forCategory: category)
            })
        }

        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

extension ItemsListViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension ItemsListViewController: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem = self.filterButtonItem

            self.view.addSubview(self.tableView)
            self.view.addConstraints([self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                      self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                      self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                      self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)])
        }
    }
}

extension ItemsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self), for: indexPath) as? ItemTableViewCell else {
            fatalError("Could not dequeue ItemTableViewCell")
        }

        cell.setup(withViewModel: self.viewModel.itemViewModel(forItemAtIndex: indexPath))

        return cell
    }
}

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(itemViewModel: self.viewModel.itemViewModel(forItemAtIndex: indexPath))

        if let detailVC = delegate as? ItemViewController {
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableViewCell.height
    }
}

extension ItemsListViewController: ItemsListViewModelDelegate {

    func didUpdateItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem?.isEnabled = self.viewModel.isFilteringEnable
        }
    }

    func didFailToFetchItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()

            let alert = UIAlertController(title: "Oops !",
                                          message: "Tout ne s'est pas déroulé comme prévu :-(\n\nOn ressaye ?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Non", style: .cancel))
            alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { _ in
                self.viewModel.fetchItemsAndCategories()
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
}
