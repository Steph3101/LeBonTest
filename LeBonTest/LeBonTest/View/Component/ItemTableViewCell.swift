//
//  ItemTableViewCell.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    static let height: CGFloat = 100

    var itemViewModel: ItemViewModel?
    private var imageDownloadTask: URLSessionTask?

    private lazy var placeholderImage: UIImage? = {
        return UIImage(named: "placeholder")
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 10.0

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.6
        view.layer.masksToBounds = false

        return view
    }()

    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView(image: self.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
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

        self.imageDownloadTask?.cancel()
        self.thumbImageView.image = self.placeholderImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(withViewModel viewModel: ItemViewModel) {
        self.itemViewModel = viewModel
        self.titleLabel.text = self.itemViewModel?.title
        self.categoryLabel.text =  self.itemViewModel?.category
        self.priceLabel.text = self.itemViewModel?.price

        if let imageUrl = self.itemViewModel?.smallImageUrl {
            self.imageDownloadTask = self.thumbImageView.downloadImage(url: imageUrl)
        }
    }
}

extension ItemTableViewCell: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {

            // Container view
            self.contentView.addSubview(self.containerView)
            self.contentView.addConstraints(
                [self.containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                 self.containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                 self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
                 self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8)])

            // Thumb image view
            self.containerView.addSubview(self.thumbImageView)
            self.containerView.addConstraints(
                [self.containerView.leadingAnchor.constraint(equalTo: self.thumbImageView.leadingAnchor),
                 self.containerView.centerYAnchor.constraint(equalTo: self.thumbImageView.centerYAnchor),
                 self.containerView.heightAnchor.constraint(equalTo: self.thumbImageView.heightAnchor),
                 self.thumbImageView.widthAnchor.constraint(equalTo: self.thumbImageView.heightAnchor)])

            // Title label
            self.containerView.addSubview(self.titleLabel)
            self.containerView.addConstraints(
                [self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
                 self.titleLabel.leadingAnchor.constraint(equalTo: self.thumbImageView.trailingAnchor, constant: 10),
                 self.containerView.trailingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor, constant: 20),])

            // Category label
            self.containerView.addSubview(self.categoryLabel)
            self.containerView.addConstraints(
                [self.categoryLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10),
                 self.categoryLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)])

            // Price label
            self.containerView.addSubview(self.priceLabel)
            self.containerView.addConstraints(
                [self.priceLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10),
                 self.priceLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
                 self.priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.categoryLabel.trailingAnchor, constant: 10)])
        }
    }
}
