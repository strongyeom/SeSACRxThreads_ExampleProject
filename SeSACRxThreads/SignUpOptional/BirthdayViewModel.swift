//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/03.
//

import Foundation
import RxSwift

class BirthdayViewModel {
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year: BehaviorSubject<Int> = BehaviorSubject(value: 2023)
    let month: BehaviorSubject<Int> = BehaviorSubject(value: 11)
    let day: BehaviorSubject<Int> = BehaviorSubject(value: 01)
    let buttonValidate = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    init() {
        birthday
            .bind { date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                self.year.onNext(component.year!)
                self.month.onNext(component.month!)
                self.day.onNext(component.day!)
            }
            .disposed(by: disposeBag)
    }
}
