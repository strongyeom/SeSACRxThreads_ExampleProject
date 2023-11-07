//
//  ShoppingListViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import Foundation
import RxSwift

class ShoppingListViewModel {
    // import UIKit을 하게 되면 쉽사리 viewmodel로 뺄 수 있다.. 하지만 UIKit을 import해주는게 맞을까...?
    var data: [AppInfo] = []
    // -> 추정 : ShoppingListVC가 deinit 되지 않았기 때문에 randomAddElement가 한번 타고 데이터가 계속 유지 됨 그렇기 때문에 한번 나온 랜덤 값으로 bind가 되면서 data가 추가되는것음
    lazy var items = BehaviorSubject(value: data)
    var disposeBag = DisposeBag()
    
    let request = SearchAPIManager
        .request()
        .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))

    init() {
        
          request
              .drive(with: self) { owner, value in
                  owner.items.onNext(value.results)
              }
              .disposed(by: disposeBag)
          

          
    }
}
