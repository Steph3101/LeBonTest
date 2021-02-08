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
        return scrollView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: self.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupData()
    }

    func setupData() {
        self.categoryLabel.text = self.viewModel?.category
        self.titleLabel.text = self.viewModel?.title
        self.priceLabel.text = self.viewModel?.price
        self.dateLabel.text = self.viewModel?.readableDate
        self.descriptionLabel.text = self.viewModel?.description

        if let imageUrl = self.viewModel?.thumbImageUrl {
            self.imageDownloadTask = self.imageView.downloadImage(url: imageUrl, placeholder: self.placeholderImage)
        }
    }
}

extension ItemViewController: UISetupable {
    func setupUI() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .blue

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
                 self.imageView.heightAnchor.constraint(equalTo: frameGuide.heightAnchor, multiplier: 1/3)])

            self.scrollView.addSubview(self.urgentImageView)
            NSLayoutConstraint.activate(
                [self.imageView.topAnchor.constraint(equalTo: self.urgentImageView.topAnchor),
                 self.imageView.trailingAnchor.constraint(equalTo: self.urgentImageView.trailingAnchor)])

            self.scrollView.addSubview(self.categoryLabel)
            NSLayoutConstraint.activate(
                [self.categoryLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
                 self.categoryLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor)])

            self.scrollView.addSubview(self.titleLabel)
            NSLayoutConstraint.activate(
                [self.titleLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 20),
                 self.titleLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor),
                 self.titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 20)
                ])

            self.scrollView.addSubview(self.priceLabel)
            NSLayoutConstraint.activate(
                [self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
                 self.priceLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor, constant: -20)])

            self.scrollView.addSubview(self.dateLabel)
            NSLayoutConstraint.activate(
                [self.dateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 20),
                 self.dateLabel.trailingAnchor.constraint(equalTo: self.priceLabel.trailingAnchor)])

            self.scrollView.addSubview(self.descriptionLabel)
            NSLayoutConstraint.activate(
                [self.descriptionLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20),
                 self.descriptionLabel.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor),
                 self.descriptionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 20),
                 self.descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentGuide.bottomAnchor, constant: -20)])

        }
    }
}

extension ItemViewController: ItemsListViewControllerDelegate {
    func didSelect(itemViewModel: ItemViewModel) {
        self.viewModel = itemViewModel
        self.setupData()
    }
}
