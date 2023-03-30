//
//  FeedCell.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 29/03/23.
//

import UIKit
import Combine

class FeedCell: UICollectionViewCell {
    // MARK: - Properties
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    lazy private var photoInfoStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.clipsToBounds = true
        return view
    }()

    lazy private var photoTitleLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(Constants.photoInfoLabelFontSize)
        view.numberOfLines = Constants.photoTitleLabelNumberOfLines
        return view
    }()

    lazy private var photoAuthorLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(Constants.photoInfoLabelFontSize)
        view.numberOfLines = Constants.photoAuthorLabelNumberOfLines
        return view
    }()

    lazy private var photoDateLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(Constants.photoInfoLabelFontSize)
        view.numberOfLines = Constants.photoDateLabelNumberOfLines
        return view
    }()

    lazy private var photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Constants
    private enum Constants {
        static let containerViewHeight = 400.0
        static let containerViewWidth = 400.0
        static let stackViewHorizontalMargin = 8.0
        static let stackViewBottomMargin = 8.0
        static let photoInfoLabelFontSize = 16.0
        static let photoTitleLabelNumberOfLines = 1
        static let photoAuthorLabelNumberOfLines = 1
        static let photoDateLabelNumberOfLines = 1
    }

    private let viewModel = FeedCellViewModel()
    private let output = PassthroughSubject<FeedCellViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        bindings()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetCellInfo()
    }

    // MARK: - Bindings
    private func bindings() {
        viewModel.transform(input: output.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                if case let .updateImage(image) = event {
                    self?.photoImageView.image = image
                }
            }.store(in: &cancellables)
    }

    // MARK: - Setup
    private func setup() {
        setupContainerView()
        setupPhotoInfoStackView()
        setupPhotoImageView()
    }

    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupPhotoImageView() {
        containerView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    private func setupPhotoInfoStackView() {
        photoImageView.addSubview(photoInfoStackView)
        NSLayoutConstraint.activate([
            photoInfoStackView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: Constants.stackViewHorizontalMargin),
            photoInfoStackView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -Constants.stackViewHorizontalMargin),
            photoInfoStackView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -Constants.stackViewBottomMargin)
        ])
        photoInfoStackView.addArrangedSubview(photoTitleLabel)
        photoInfoStackView.addArrangedSubview(photoAuthorLabel)
        photoInfoStackView.addArrangedSubview(photoDateLabel)
    }

    // MARK: - Configure
    func configure(with photo: FlickrPhotoModel) {
        guard let stringURL = photo.imageURL,
            let url = URL(string: stringURL) else {
                resetCellInfo()
                return
            }

        photoTitleLabel.text = photo.title
        photoAuthorLabel.text = photo.author
        photoDateLabel.text = photo.publishedAt
        output.send(.cellWillAppear(url: url))
    }

    private func resetCellInfo() {
        photoImageView.image = nil
        photoTitleLabel.text = ""
        photoAuthorLabel.text = ""
        photoDateLabel.text = ""
    }
}
