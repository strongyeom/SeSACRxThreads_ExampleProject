//
//  DetailAppInfoViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/07.
//

import UIKit
import RxSwift

class DetailAppInfoViewController : UIViewController {


    var appinfo: [Section : [AppInfo]] = [
        Section.first : [AppInfo(screenshotUrls: [], trackName: "123123", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: "")],

        Section.second : [AppInfo(screenshotUrls: [], trackName: "321", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "321", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "321", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "321", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: "")],
        Section.third : [AppInfo(screenshotUrls: [], trackName: "dsads", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "dsads", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "dsads", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""), AppInfo(screenshotUrls: [], trackName: "dsads", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: "")],
        Section.fourth : [AppInfo(screenshotUrls: [], trackName: "asd123", genres: [], trackContentRating: "", description: "", price: 0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: "")]
    ]


    enum Section: Int, CaseIterable {
        case first
        case second
        case third
        case fourth

        var columnCount: Int {
            switch self {
            case .first:
                return 1
            case .second:
                return 5
            case .third:
                return 4
            case .fourth:
                return 1
            }
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, AppInfo>! = nil
    var collectionView: UICollectionView! = nil




    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDatSource()
    }



    func configure() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)
    }

    func configureDatSource() {

        let firstCellRegistration = UICollectionView.CellRegistration<FirstCell, AppInfo> { (cell, indexPath, identifier) in
            cell.label.text = identifier.trackName
        }

        let secondCellRegistration = UICollectionView.CellRegistration<SecondCell, AppInfo> { (cell, indexPath, identifier) in
            cell.label.text = identifier.trackName
        }

        let thirdCellRegistration = UICollectionView.CellRegistration<ThirdCell, AppInfo> { (cell, indexPath, identifier) in
            cell.label.text = identifier.trackName
        }

        let fourthCellRegistration = UICollectionView.CellRegistration<FourthCell, AppInfo> { (cell, indexPath, identifier) in
            cell.label.text = identifier.trackName
        }


        dataSource = UICollectionViewDiffableDataSource<Section, AppInfo>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in

            print("indexPath---- \(indexPath)")
            let section = Section(rawValue: indexPath.section)!
           // print("----- section : \(section)")
//            switch section {
//            case .first:
//                return collectionView.dequeueConfiguredReusableCell(using: firstCellRegistration, for: indexPath, item: itemIdentifier)
//            case .second:
//                return collectionView.dequeueConfiguredReusableCell(using: secondCellRegistration, for: indexPath, item: itemIdentifier)
//            case .third:
//                return collectionView.dequeueConfiguredReusableCell(using: thirdCellRegistration, for: indexPath, item: itemIdentifier)
//            case .fourth:
//                return collectionView.dequeueConfiguredReusableCell(using: fourthCellRegistration, for: indexPath, item: itemIdentifier)
//            }


            if Section(rawValue: indexPath.section)! == .first {
                return collectionView.dequeueConfiguredReusableCell(using: firstCellRegistration, for: indexPath, item: itemIdentifier)
            } else if Section(rawValue: indexPath.section)! == .second {
                return collectionView.dequeueConfiguredReusableCell(using: secondCellRegistration, for: indexPath, item: itemIdentifier)
            } else if Section(rawValue: indexPath.section)! == .third {
                return collectionView.dequeueConfiguredReusableCell(using: thirdCellRegistration, for: indexPath, item: itemIdentifier)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: fourthCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })


        var snapShot = NSDiffableDataSourceSnapshot<Section, AppInfo>()
//
//        Section.allCases.forEach {
//            print("-0000--- \($0)")
//            snapShot.appendSections([$0])
//            print("------- appinfo ---- \(appinfo)")
//            snapShot.appendItems(appinfo, toSection: $0)
//        }

       // let aa = appinfo[.first]

        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(appinfo[.first]!, toSection: .first)
        snapShot.appendItems(appinfo[.second]!, toSection: .second)
        snapShot.appendItems(appinfo[.third]!, toSection: .third)
        snapShot.appendItems(appinfo[.fourth]!, toSection: .fourth)
        dataSource.apply(snapShot, animatingDifferences: true)
    }

}

extension DetailAppInfoViewController {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            let columns = sectionLayoutKind.columnCount

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let groupSize: NSCollectionLayoutSize
            let group: NSCollectionLayoutGroup

            switch sectionLayoutKind {
            case .first:
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(100))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            case .second:
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .absolute(50))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            case .third:
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                                   heightDimension: .absolute(300))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            case .fourth:
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(120))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            }

            // section 별로 페이징스크롤 다르게 처리하기



            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }




}


/*
 var detailInfo: AppInfo?

 let detailView = DetailView()

 override func loadView() {
     self.view = detailView
 }

 override func viewDidLoad() {
     super.viewDidLoad()
     view.backgroundColor = .white
    // dump(detailInfo)
     detailView.setUI(data: detailInfo)
     self.navigationController?.navigationBar.prefersLargeTitles = false

 }
 */
