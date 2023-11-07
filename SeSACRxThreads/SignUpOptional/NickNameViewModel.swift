//
//  NickNameViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/03.
//

import Foundation
import RxSwift

class NickNameViewModel {
    let inputText = BehaviorSubject(value: "")
    let titleLabelHidden = BehaviorSubject(value: true)
    let buttonEnabled = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        inputText
            .map { $0.count >= 2 && $0.count < 6 }
            .bind { value in
                self.buttonEnabled.onNext(value)
                self.titleLabelHidden.onNext(value)
            }
            .disposed(by: disposeBag)
    }
}
