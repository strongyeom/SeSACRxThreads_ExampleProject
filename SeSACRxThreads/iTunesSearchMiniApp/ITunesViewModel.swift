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
        
    }
    
    struct Output {
        let zip: Observable<ControlEvent<AppInfo>.Element>
    }
    
    func transform(input: Input) -> Output {
        
        let zip = input.zip
            .map { $0.1}
        
        return Output(zip: zip)
    }
}
