//
//  ITunesViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class ITunesViewModel {
    
    var items = PublishSubject<[AppInfo]>()
    var searchText: String = "카카오톡"
    let disposeBag = DisposeBag()

    // input 뭐가 있을까?
    // 받기 버튼, 사용자가 직접 입력, CellClicked

    struct Input {
        let zip : Observable<(ControlEvent<IndexPath>.Element, ControlEvent<AppInfo>.Element)>
         let searchClicked: ControlEvent<Void>
        let text: ControlProperty<String>
    }
    
    struct Output {
        let zip: Observable<ControlEvent<AppInfo>.Element>
        let items: PublishSubject<[AppInfo]>
        let search: Observable<[AppInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let zip = input.zip
            .map { $0.1 }
        
        let search = input.searchClicked
            .withLatestFrom(input.text)
            .throttle(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .debug()
            //.distinctUntilChanged()
            .flatMap {
                SearchAPIManager.requestSearch(searchString: $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            }
            .map { $0.results }
        
        
        
        return Output(zip: zip, items: items, search: search)
    }
    
    init() {
        /// 네트워크 통신 - 초기값 세팅
        let request = SearchAPIManager
            .requestSearch(searchString: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, response in
                owner.items.onNext(response.results)
            }
            .disposed(by: disposeBag)
    }
}
