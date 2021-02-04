//
//  ItemViewController.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

final class ItemViewController: UIViewController {
    var viewModel: ItemViewModel? = nil

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupData()
    }

    func setupData() {
        self.titleLabel.text = self.viewModel?.name
    }
}

extension ItemViewController: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .blue

            self.view.addSubview(self.titleLabel)
            self.view.addConstraints(
                [self.view.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor),
                 self.view.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)])

        }
    }
}

extension ItemViewController: ItemsListViewControllerDelegate {
    func didSelect(itemViewModel: ItemViewModel) {
        self.viewModel = itemViewModel
        self.setupData()
    }
}
