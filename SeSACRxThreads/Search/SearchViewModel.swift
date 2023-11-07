//
//  SearchViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/04.
//

import Foundation
import RxSwift
import UIKit

class SearchViewModel {
    
    let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
  
    var data = ["A", "B", "C" , "D"]
     
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    init() {
        
            
 
            
            // modelSelected : 해당 TableViewCell의 element 값만
            tableView.rx.modelSelected(String.self)
                .subscribe(with: self) { owner, row in
                    print("modelSelected - \(row)")
                }
                .disposed(by: disposeBag)
            
            
            // itemSelected : 해당 tableViewCell의 index만
            tableView.rx.itemSelected
                .subscribe(with: self) { owner, value in
                    print("itemSelected - \(value)")
                }
                .disposed(by: disposeBag)
            
            // zip
            Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
                .map { "\($0) : \($1)"}
                .subscribe(with: self) { owner, value in
                    print("zip - \(value)")
                }
                .disposed(by: disposeBag)
            
    //        searchBar.rx.searchButtonClicked
    //            .withLatestFrom(searchBar.rx.text.orEmpty)
    //            // 클릭시 중복 일때 무시
    //            .distinctUntilChanged()
    //            .subscribe(with: self, onNext: { owner, value in
    //                print("searchButtonClicked - \(value)")
    //                owner.data.insert(value, at: 0)
    //                owner.items.onNext(owner.data)
    //            })
    //            .disposed(by: disposeBag)
            
            searchBar.rx.text.orEmpty
                // 계속 서치하는게 아니라 검색 버튼을 눌렀을때 +1 후 실행, 즉 문자열이 추가로 써지지 않으면 + 1 후 검색 실행
                .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .subscribe(with: self) { owner, value in
                    let result = value == "" ? owner.data : owner.data.filter { $0.contains(value)}
                    print("text.orEmpty - \(value)")
                    owner.items.on(.next(result))
                }
                .disposed(by: disposeBag)
            
    }
}
