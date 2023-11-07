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
    
    let viewModel = ITunesViewModel()
     
    let searchController = UISearchController()
    

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        settingSearchController()
        bind()
    }
    
    func bind() {
        
        
        let input = ITunesViewModel.Input(zip: Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(AppInfo.self)), searchClicked: searchController.searchBar.rx.searchButtonClicked, text: searchController.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        ///TableView에 데이터 뿌려주기
        output.items
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
        output.zip
            .debug()
            .subscribe(with: self) { owner, result in
                let detailVC = DetailAppInfoViewController()
                detailVC.detailInfo = result
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        
        
        /// 네트워크 통신 - 초기값 세팅
//        let request = SearchAPIManager
//            .requestSearch(searchString: viewModel.searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
//
//        request
//            .drive(with: self) { owner, response in
//                owner.viewModel.items.onNext(response.results)
//            }
//            .disposed(by: disposeBag)
            
        
        
        /// 서치 검색 클릭 후 네트워크 통신
//        searchController.searchBar.rx.searchButtonClicked
//            .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
//            .throttle(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
//            .debug()
//            //.distinctUntilChanged()
//            .flatMap {
//                SearchAPIManager.requestSearch(searchString: $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//            }
//            .map { $0.results }
            output.search
            .bind(with: self, onNext: { owner, value in
                owner.viewModel.items.onNext(value)
            })

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
