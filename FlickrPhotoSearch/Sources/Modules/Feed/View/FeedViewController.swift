//
//  FeedViewController.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import UIKit

class FeedViewController: UIViewController {
    let viewModel = FeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getFeed()
    }

}

