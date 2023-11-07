//
//  ValidationViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/08.
//

import Foundation
import RxSwift
import RxCocoa

class ValidationViewModel {
    
    // input 액션 클릭, 사용자 반응
    
    // output 결과 값
    
   
    
    struct Input {
        let text: ControlProperty<String>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Observable<Bool>
        let tap: ControlEvent<Void>
        let valideText: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let text = input.text
            .map { $0.count >= 8}
        
        
        let tap = input.tap
        
        let validText = BehaviorRelay(value: "닉네임은 8글자 이상")
            .asDriver()
        
        
        return Output(text: text, tap: tap, valideText: validText)
    }
}
