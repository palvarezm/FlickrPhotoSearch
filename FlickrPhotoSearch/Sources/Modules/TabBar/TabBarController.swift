//
//  TabBarController.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation
import UIKit

typealias Tabs = (
    feed: UIViewController,
    search: UIViewController
)

class TabBarController: UITabBarController {
    init(tabs: Tabs = (FeedViewController(), SearchViewController())) {
        super.init(nibName: nil, bundle: nil)
        tabs.feed.tabBarItem.title = "feed_tab_bar_title".localized
        tabs.search.tabBarItem.title = "search_tab_bar_title".localized
        self.viewControllers = [tabs.feed, tabs.search]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setSearchFeed(searchText: String) {
        guard let feedViewController = self.viewControllers?.first as? FeedViewController else { return }

        self.selectedIndex = 0
        feedViewController.updateSearchPhotos(searchText: searchText)
    }
}
