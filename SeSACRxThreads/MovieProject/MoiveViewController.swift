//
//  MoiveViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import UIKit
import RxSwift
import RxCocoa

class MoiveViewController: UIViewController {
    
    let tableView = {
        let table = UITableView()
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        table.backgroundColor = .white
        table.rowHeight = 80
        table.separatorStyle = .none
        return table
    }()
    
    
    
    let disposeBag = DisposeBag()
   
    let viewModel = MovieViewModel()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MoiveViewController - viewDidLoad")
        configure()
        bind()
        navigationItem.titleView = searchBar
    }
    
    func bind() {
        
        let input = MovieViewModel.Input(items: viewModel.items, request: MovieAPIManager.request(date: viewModel.inputData), search: searchBar.rx.searchButtonClicked, text: searchBar.rx.text)
        
        let output = viewModel.transform(input: input)
        
        
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { row, element, cell in
                cell.moviename.text = element.movieNm
                cell.openDate.text = element.openDt
            }
            .disposed(by: disposeBag)
        
//        let request = MovieAPIManager
//            .request(date: viewModel.inputData)
//            .asDriver(onErrorJustReturn: MovieModel(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
        
        output.request
            .drive(with: self) { owner, value in
                owner.viewModel.items.onNext(value.boxOfficeResult.dailyBoxOfficeList)
            }
            .disposed(by: disposeBag)
        
        output.request
            .map { "\($0.boxOfficeResult.dailyBoxOfficeList.count)개의 영화들"}
            .drive(with: self) { owner, value in
                owner.navigationItem.title = value
            }
            .disposed(by: disposeBag)
        
        
        output.search
            .bind(with: self) { owner, value in
                // owner.searchBar.placeholder = "Date 날짜를 입력해주세요 - 생략"
                print("setSearchBar - text : \(value)")
                owner.viewModel.items.onNext(value.boxOfficeResult.dailyBoxOfficeList)
               // viewModel.inputData = value
                
//                let request = MovieAPIManager
//                    .request(date: viewModel.inputData)
//                    .asDriver(onErrorJustReturn: MovieModel(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
//
//                request
//                    .drive(with: self) { owner, value in
//                        owner.items.onNext(value.boxOfficeResult.dailyBoxOfficeList)
//                    }
//                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    
    func configure() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
