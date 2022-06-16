//
//  ViewController.swift
//  Custom photos collection
//
//  Created by Григорий Виняр on 15/06/2022.
//

import UIKit

class CollectionVC: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case list, grade3
        var columnCount: Int {
            switch self {
            case .list:
                return 2
            case .grade3:
                return 3
            }
        }
    }
    
    var albums = [Albums]()
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupNavigationBar()
        getDataIntoCollectionView()
    }
    
    // MARK: Methods
    
    private func getDataIntoCollectionView() {
        NetworkService().getDataFromService { [weak self] albums in
            DispatchQueue.main.async {
                self?.albums = albums
                self?.configureCollectionView()
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reuseID)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseID)
        
        view.addSubview(collectionView)
        
        setupDataSource()
        reloadData()
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("Error \(cellType)")
        }
        let album = albums[indexPath.row]
        guard let imageURL = URL(string: album.url) else { return UITableViewCell() as! T }
        guard let data = try? Data(contentsOf: imageURL) else { return UITableViewCell() as! T}
        cell.configure(with: (UIImage(data: data) ?? UIImage(systemName: "car"))!, title: album.title)
        
        return cell
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) in
            
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .list:
                return self?.createListLayout()
            case .grade3:
                return self?.createGradeLayout()
            }
        }
        return layout
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, intValue in
            let section = SectionKind(rawValue: indexPath.section)!
            
            switch section {
            case .list:
                return self.configure(cellType: NumberCell.self, with: intValue, for: indexPath)
            case .grade3:
                return self.configure(cellType: ImageCell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        let itemPerSection = 10
        SectionKind.allCases.forEach { (sectionKind) in
            let itemOffSet = sectionKind.columnCount * itemPerSection
            let itemUpperbound = itemOffSet + itemPerSection
            snapshot.appendSections([sectionKind])
            snapshot.appendItems(Array(itemOffSet..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createGradeLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 5, bottom: 5, trailing: 5)
        
        return section
    }
    
    private func createListLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(160),
                                               heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 20, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Photos"
    }

}

// MARK: - SwiftUI
