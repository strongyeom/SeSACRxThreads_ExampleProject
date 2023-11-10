//
//  ShoppingViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/10.
//

import Foundation
import RxSwift
import RxCocoa

protocol InOut {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ShoppingViewModel: InOut {
    
    var data: [AppInfo] = []
 
    lazy var items = BehaviorSubject(value: data)

    let disposeBag = DisposeBag()
    
    struct Input {
        
        let cellTap: ControlEvent<AppInfo>
        let btnTap: ControlEvent<Void>
        let tableItemDeleted: ControlEvent<IndexPath>
        let tableViewItemMoved: ControlEvent<ItemMovedEvent>
    }
    
    struct Output {
        let cellTap: ControlEvent<AppInfo>
        let btnTap: ControlEvent<Void>
        let deleted: Observable<IndexPath>
        let tableViewItemMoved: Observable<Int>
    }
    
    func transform(input: Input) -> Output {
        
        let cellTap = input.cellTap
        
        let btnTap = input.btnTap
        
        let delete = input.tableItemDeleted
            .observe(on: MainScheduler.asyncInstance) // vs MainScheduler.instance
        
        let moved = input.tableViewItemMoved
            .map { $0.destinationIndex.row }
        
        return Output(cellTap: cellTap, btnTap: btnTap, deleted: delete, tableViewItemMoved: moved)
    }
    
    
    
    
    init() {
        let request = SearchAPIManager
            .request()
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, response in
                
                owner.data = response.results
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
}
