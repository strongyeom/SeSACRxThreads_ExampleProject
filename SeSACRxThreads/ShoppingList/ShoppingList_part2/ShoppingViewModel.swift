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
    }
    
    struct Output {
        let cellTap: ControlEvent<AppInfo>
    }
    
    func transform(input: Input) -> Output {
        
        Output(cellTap: input.cellTap)
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
