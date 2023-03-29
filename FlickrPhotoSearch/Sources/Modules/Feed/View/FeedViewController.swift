//
//  FeedViewController.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    // MARK: - Properties
    lazy private var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "feed_trending_now_title".localized
        view.font = view.font.withSize(Constants.titleLabelFontSize)
        return view
    }()

    lazy private var photosCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    let viewModel = FeedViewModel()

    private let output = PassthroughSubject<FeedViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Constants
    private enum Constants {
        static let leadingMargin = 24.0
        static let trailingMargin = 24.0
        static let photosCollectionViewTopMargin = 24.0
        static let titleLabelFontSize = 32.0
        static let backgroundColor: UIColor = .black
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindings()
        output.send(.viewDidLoad)
        setup()
    }

    // MARK: - Bindings
    private func bindings() {
        viewModel.transform(input: output.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .updateList:
                    self?.photosCollectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = Constants.backgroundColor
        setupTitleLabel()
        setupCollectionView()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingMargin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingMargin)
        ])
    }

    private func setupCollectionView() {
        view.addSubview(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.photosCollectionViewTopMargin),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingMargin),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.trailingMargin),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        photosCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: String(describing: FeedCell.self))
    }
}

// MARK: - Extension UICollectionViewDelegate & UICollectionViewDataSource
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedCell.self), for: indexPath) as? FeedCell else { return UICollectionViewCell() }

        let flickrPhoto = viewModel.photoList[indexPath.row]
        cell.configure(with: flickrPhoto)
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flickrPhoto = viewModel.photoList[indexPath.row]
        return CGSize(width: flickrPhoto.imageWidth, height: flickrPhoto.imageHeight)
    }
}
