//
//  HomePageViewController.swift
//  booksApp
//
//  Created by оля on 08.10.2020.
//  Copyright © 2020 Olya. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    static let sectionHeaderElementKind = "SectionHeader"

    let sectionHeadersSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(20))
        
    var popularItems = [CollectionItem(imageName: "popular1", title: "Conversations with", author: "Sally Rooney"),
                        CollectionItem(imageName: "popular2", title: "This Is How It Alwa", author: "Laurie Frankel"),
                        CollectionItem(imageName: "popular3", title: "A Teaspoon of Earth and Sea", author: "Dina Nayeri")]
    
    var discoverItems = [CollectionItem(imageName: "discover")]
    
    var recommendedItems = [CollectionItem(imageName: "recommended1"), CollectionItem(imageName: "recommended2"),
        CollectionItem(imageName: "recommended3")]
    
    enum Section: String, CaseIterable {
        case discover = "Discover"
        case popular = "Popular"
        case recommended = "Recommended"
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, CollectionItem>! = nil
    var booksCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type book name or author"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        configureCollectionView()
        configureDataSource()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            
            switch (sectionLayoutKind) {
            case .discover: return self.generateDiscoverItemsLayout()
            case .popular: return self.generatePopularItemsLayout()
            case .recommended: return self.generateRecommendedItemsLayout()
            }
        }
        
        return layout
    }
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(DiscoverItemCellView.self, forCellWithReuseIdentifier: DiscoverItemCellView.reuseIdentifer)
        collectionView.register(RecommendedItemCellView.self, forCellWithReuseIdentifier: RecommendedItemCellView.reuseIdentifer)
        collectionView.register(PopularItemCellView.self, forCellWithReuseIdentifier: PopularItemCellView.reuseIdentifer)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: HomePageViewController.sectionHeaderElementKind,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
        
        booksCollectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
            <Section, CollectionItem>(collectionView: booksCollectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, detailItem: CollectionItem) -> UICollectionViewCell? in
                
                let sectionType = Section.allCases[indexPath.section]
                
                switch sectionType {
                case .discover:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DiscoverItemCellView.reuseIdentifer,
                        for: indexPath) as? DiscoverItemCellView
                        else { fatalError("Could not create new cell") }
                    
                    cell.imageName = detailItem.imageName
                    return cell
                    
                case .popular:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PopularItemCellView.reuseIdentifer,
                        for: indexPath) as? PopularItemCellView
                        else { fatalError("Could not create new cell") }
                    
                    cell.imageName = detailItem.imageName
                    cell.title = detailItem.title
                    cell.author = detailItem.author
                    
                    return cell
                    
                case .recommended:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: RecommendedItemCellView.reuseIdentifer,
                        for: indexPath) as? RecommendedItemCellView
                        else { fatalError("Could not create new cell") }
                    
                    cell.imageName = detailItem.imageName
                    return cell
                }
                
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
            
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, CollectionItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>()
        
        snapshot.appendSections([Section.discover, Section.popular, Section.recommended])
        
        snapshot.appendItems(popularItems, toSection: .popular)
        snapshot.appendItems(discoverItems, toSection: .discover)
        snapshot.appendItems(recommendedItems, toSection: .recommended)
        
        return snapshot
    }
    
    func generateDiscoverItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/2 + 1/15))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HomePageViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generatePopularItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(255))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 5)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeadersSize,
            elementKind: HomePageViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateRecommendedItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(210))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 5)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeadersSize,
            elementKind: HomePageViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

extension HomePageViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}
