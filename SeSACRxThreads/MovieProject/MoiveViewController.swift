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
    
    let data: [DailyBoxOfficeList] = []
    lazy var items = BehaviorSubject(value: data)
    let disposeBag = DisposeBag()
    var inputData = 20190801
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MoiveViewController - viewDidLoad")
        configure()
        bind()
        setSearchBar()
    }
    
    func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { row, element, cell in
                cell.moviename.text = element.movieNm
                cell.openDate.text = element.openDt
            }
            .disposed(by: disposeBag)
        
        let request = MovieAPIManager
            .request(date: inputData)
            .asDriver(onErrorJustReturn: MovieModel(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
        
        request
            .drive(with: self) { owner, value in
                owner.items.onNext(value.boxOfficeResult.dailyBoxOfficeList)
            }
            .disposed(by: disposeBag)
        
        request
            .map { "\($0.boxOfficeResult.dailyBoxOfficeList.count)개의 영화들"}
            .drive(with: self) { owner, value in
                owner.navigationItem.title = value
            }
            .disposed(by: disposeBag)
        
    }
    
    func setSearchBar() {
        navigationItem.titleView = searchBar
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { Int($0)! }
            .bind(with: self) { owner, value in
                // owner.searchBar.placeholder = "Date 날짜를 입력해주세요 - 생략"
                print("setSearchBar - text : \(value)")
                owner.inputData = value
                
                let request = MovieAPIManager
                    .request(date: owner.inputData)
                    .asDriver(onErrorJustReturn: MovieModel(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
                
                request
                    .drive(with: self) { owner, value in
                        owner.items.onNext(value.boxOfficeResult.dailyBoxOfficeList)
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
}
