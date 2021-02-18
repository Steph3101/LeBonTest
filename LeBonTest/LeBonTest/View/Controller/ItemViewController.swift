//
//  ItemViewController.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

final class ItemViewController: UIViewController {
    var viewModel: ItemViewModel? = nil

    private var imageDownloadTask: URLSessionTask?

    private lazy var placeholderImage: UIImage? = {
        return UIImage(named: "placeholder")
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: self.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var urgentImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "urgent"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = Font.light.withSize(14)
        label.textColor = .darkGray
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = Font.bold.withSize(18)
        label.textColor = .darkGray
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = Font.extraBold.withSize(17)
        label.textColor = .systemGreen
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = Font.medium
        label.textColor = .darkGray
        
        return label
    }()

    private lazy var descriptionBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 5

        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Font.medium
        label.textColor = .white
        label.backgroundColor = .clear

        return label
    }()

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "LeBonTest"
        label.textAlignment = .center
        label.font = Font.black.withSize(35)
        label.textColor = .systemGreen
        label.backgroundColor = .white

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupData()
        self.title = "Fiche"
    }

    func setupData() {
        guard let viewModel = self.viewModel else {
            return
        }

        DispatchQueue.main.async {
            self.emptyStateLabel.removeFromSuperview()
        }

        self.categoryLabel.text = viewModel.category
        self.titleLabel.text = viewModel.title
        self.priceLabel.text = viewModel.price
        self.dateLabel.text = viewModel.readableDate
        self.descriptionLabel.text = viewModel.description
        self.urgentImageView.isHidden = viewModel.isUrgent == false
        self.imageView.image = self.placeholderImage

        if let imageUrl = viewModel.thumbImageUrl {
            self.imageDownloadTask = self.imageView.downloadImage(url: imageUrl, placeholder: self.placeholderImage)
        }
    }
}

extension ItemViewController: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white

            self.view.addSubview(self.scrollView)
            let frameGuide = self.scrollView.frameLayoutGuide
            let contentGuide = self.scrollView.contentLayoutGuide

            // ScrollView
            NSLayoutConstraint.activate(
                [frameGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                 frameGuide.topAnchor.constraint(equalTo: self.view.topAnchor),
                 frameGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                 frameGuide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                 contentGuide.widthAnchor.constraint(equalTo: frameGuide.widthAnchor)])

            self.scrollView.addSubview(self.imageView)
            NSLayoutConstraint.activate(
                [self.imageView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
                 self.imageView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                 self.imageView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
                 self.imageView.heightAnchor.constraint(equalTo: frameGuide.heightAnchor, multiplier: 1/2)])

            self.scrollView.addSubview(self.urgentImageView)
            NSLayoutConstraint.activate(
                [self.imageView.topAnchor.constraint(equalTo: self.urgentImageView.topAnchor),
                 self.imageView.trailingAnchor.constraint(equalTo: self.urgentImageView.trailingAnchor)])

            self.scrollView.addSubview(self.categoryLabel)
            NSLayoutConstraint.activate(
                [self.categoryLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 15),
                 self.categoryLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor)])

            self.scrollView.addSubview(self.titleLabel)
            NSLayoutConstraint.activate(
                [self.titleLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 20),
                 self.titleLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor),
                 self.titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 20)
                ])

            self.scrollView.addSubview(self.priceLabel)
            NSLayoutConstraint.activate(
                [self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
                 self.priceLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 20)])

            self.scrollView.addSubview(self.dateLabel)
            NSLayoutConstraint.activate(
                [self.dateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 8),
                 self.dateLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 20)])

            self.scrollView.addSubview(self.descriptionBackgroundView)
            self.scrollView.addSubview(self.descriptionLabel)

            NSLayoutConstraint.activate(
                [self.descriptionLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 50),
                 self.descriptionLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor),
                 self.descriptionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 40)])

            NSLayoutConstraint.activate(
                [self.descriptionBackgroundView.centerXAnchor.constraint(equalTo: self.descriptionLabel.centerXAnchor),
                 self.descriptionBackgroundView.centerYAnchor.constraint(equalTo: self.descriptionLabel.centerYAnchor),
                 self.descriptionBackgroundView.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor, constant: -20),
                 self.descriptionBackgroundView.topAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -20),
                 self.descriptionBackgroundView.bottomAnchor.constraint(greaterThanOrEqualTo: contentGuide.bottomAnchor, constant: -20)])

            self.view.addSubview(self.emptyStateLabel)
            NSLayoutConstraint.activate(
                [self.emptyStateLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
                 self.emptyStateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                 self.emptyStateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                 self.emptyStateLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        }
    }
}

extension ItemViewController: ItemsListViewControllerDelegate {
    func didSelect(itemViewModel: ItemViewModel) {
        self.viewModel = itemViewModel
        self.setupData()
    }
}
