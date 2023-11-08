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

            /// 서치시 네트워크 통신 후 배열에  items에 저장
            output.search
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
