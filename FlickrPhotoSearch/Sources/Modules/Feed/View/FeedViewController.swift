//
//  FeedViewController.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    let viewModel = FeedViewModel()

    private let output = PassthroughSubject<FeedViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindings()
        output.send(.viewDidLoad)
    }

    private func bindings() {
        viewModel.transform(input: output.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .updateList:
                    self?.viewModel.photoList.forEach { print($0) }
                }
            }
            .store(in: &cancellables)
    }
}

