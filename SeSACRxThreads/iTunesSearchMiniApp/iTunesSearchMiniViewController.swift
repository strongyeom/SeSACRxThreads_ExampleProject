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
    
     
    let searchController = UISearchController()
    var items: BehaviorSubject<[AppInfo]> = BehaviorSubject(value: [])
    var searchText: String = "카카오톡"
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
                
                cell.setUI(data: element)
                
                cell.downloadButton.rx.tap
                    .bind(with: self) { owner, _ in
                        print("ITunesSearchMiniViewController - 받기 버튼 눌림")
                    }
                    .disposed(by: cell.disposeBag)
                
               
            }
            .disposed(by: disposeBag)
        
        /// TableView 클릭후 화면 전환
//        tableView.rx.modelSelected(AppInfo.self)
//            .subscribe(with: self) { owner, result in
//                let detailVC = DetailAppInfoViewController()
//                detailVC.detailInfo = result
//                owner.navigationController?.pushViewController(detailVC, animated: true)
//            }
//            .disposed(by: disposeBag)
//
        /// TableView 클릭후 화면 전환
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(AppInfo.self))
            .map { $0.1 }
            .debug()
            .subscribe(with: self) { owner, result in
                let detailVC = DetailAppInfoViewController()
                detailVC.detailInfo = result
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        
        
        /// 네트워크 통신 - 초기값 세팅
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
            .throttle(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .debug()
            .distinctUntilChanged()
            .flatMap {
                SearchAPIManager.requestSearch(searchString: $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            }
            .map { $0.results }
            .bind(with: self, onNext: { owner, value in
                owner.items.onNext(value)
            })
            
//            .bind(with: self) { owner, text in
//                let result = SearchAPIManager.requestSearch(searchString: text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//                    .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
//
//                result
//                    .drive(with: self) { owner, response in
//                        owner.items.onNext(response.results)
//                    }
//                    .disposed(by: owner.disposeBag)
        
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
