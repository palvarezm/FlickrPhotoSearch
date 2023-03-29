//
//  SearchViewController.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import UIKit

class SearchViewController: UISearchContainerViewController {
    // MARK: - Initializers
    init() {
        let searchViewController = UISearchController()
        let searchBar = searchViewController.searchBar
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = Constants.searchBarBackgroundColor

        searchBar.sizeToFit()
        searchBar.placeholder = "search_search_bar_placeholder".localized
        super.init(searchController: searchViewController)

        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Constants
    private enum Constants {
        static let viewBackgroundColor = UIColor.black
        static let searchBarBackgroundColor = UIColor.black
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchSuggestions = nil
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = Constants.viewBackgroundColor
    }
}

// MARK: - Extension UISearchBarDelegate, UISearchResultsUpdating
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text,
              !searchBarText.isEmpty else {
                  searchController.searchSuggestions = nil
                  return
              }

        searchController.searchSuggestions = [UISearchSuggestionItem(localizedSuggestion: searchBarText)]
    }

    func updateSearchResults(for searchController: UISearchController, selecting searchSuggestion: UISearchSuggestion) {
        guard let searchText = searchSuggestion.localizedSuggestion,
              !searchText.isEmpty,
              let tabBarController = tabBarController as? TabBarController else { return }

        tabBarController.setSearchFeed(searchText: searchText)
    }
}
