//
//  ItemTableViewCell.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    var itemViewModel: ItemViewModel?

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .systemPink
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(withViewModel viewModel: ItemViewModel) {
        self.itemViewModel = viewModel
        self.titleLabel.text = self.itemViewModel?.name
    }
}

extension ItemTableViewCell: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {
            self.contentView.addSubview(self.containerView)
            self.contentView.addConstraints(
                [self.containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                 self.containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                 self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
                 self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)])

            self.containerView.addSubview(self.titleLabel)
            self.containerView.addConstraints(
                [self.containerView.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor),
                 self.containerView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)])

        }
    }
}
