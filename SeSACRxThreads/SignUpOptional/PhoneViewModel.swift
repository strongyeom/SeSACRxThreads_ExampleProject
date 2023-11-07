//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/03.
//

import Foundation
import RxSwift

class PhoneViewModel {
    let phone: BehaviorSubject<String> = BehaviorSubject(value: "010")
    let buttonEnabled: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init() {
        
    }
}
