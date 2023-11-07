//
//  iTunesSearchMiniViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ITunesSearchMiniViewController : UIViewController {
    
    
    let tableView = {
       let table = UITableView()
        table.register(ITunesTableViewCell.self, forCellReuseIdentifier: ITunesTableViewCell.identifier)
        table.backgroundColor = .white
        table.rowHeight = 280
        table.separatorStyle = .none
        return table
    }()
    
    var data: [AppInfo] = []
    let searchController = UISearchController()
    lazy var items = BehaviorSubject(value: data)
    var searchText: String = ""
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        settingSearchController()
        bind()
    }
    
    func bind() {
        
        ///TableView에 데이터 뿌려주기
        items
            .bind(to: tableView.rx.items(cellIdentifier: ITunesTableViewCell.identifier, cellType: ITunesTableViewCell.self)) { row, element, cell in
                let iconImageUrl = URL(string: element.artworkUrl512)!
                cell.appIconImageView.kf.setImage(with: iconImageUrl)
                cell.selectionStyle = .none
                cell.appNameLabel.text = element.trackName
                let scShot1 = URL(string: element.screenshotUrls[0])!
                let scShot2 = URL(string: element.screenshotUrls[1])!
                let scShot3 = URL(string: element.screenshotUrls[2])!
                
                cell.firstImage.kf.setImage(with: scShot1)
                cell.secondImage.kf.setImage(with: scShot2)
                cell.thirdImage.kf.setImage(with: scShot3)
                cell.downloadButton.rx.tap
                    .bind(with: self) { owner, _ in
                        print("ITunesSearchMiniViewController - 받기 버튼 눌림")
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        /// TableView 클릭후 화면 전환
        tableView.rx.modelSelected(AppInfo.self)
            .subscribe(with: self) { owner, result in
                let detailVC = DetailAppInfoViewController()
                detailVC.detailInfo = result
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 네트워크 통신
        let request = SearchAPIManager
            .requestSearch(searchString: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, response in
                owner.items.onNext(response.results)
            }
            .disposed(by: disposeBag)
            
        
        
        /// 서치 검색 클릭 후 네트워크 통신
        searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                let result = SearchAPIManager.requestSearch(searchString: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
                    
                result
                    .drive(with: self) { owner, response in
                        owner.items.onNext(response.results)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    
    func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func settingSearchController() {
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}
