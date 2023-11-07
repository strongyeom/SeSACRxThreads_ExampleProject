//
//  MovieViewModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class MovieViewModel {
    var items = PublishSubject<[DailyBoxOfficeList]>()
    let disposeBag = DisposeBag()
    var inputData = 20190801
    
    struct Input {
        let items: PublishSubject<[DailyBoxOfficeList]>
        let request: Observable<MovieModel>
        let search: ControlEvent<Void>
        let text: ControlProperty<String?>
    }
    
    struct Output {
        let items: PublishSubject<[DailyBoxOfficeList]>
        let request: SharedSequence<DriverSharingStrategy, MovieModel>
        let search: Observable<MovieModel>
    }
    
    func transform(input: Input) -> Output {
        
        let request = input.request
            .asDriver(onErrorJustReturn: MovieModel(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
        
        let search = input.search
            .withLatestFrom(input.text.orEmpty)
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .map { Int($0)! }
            .flatMap {
                MovieAPIManager.request(date: $0)
            }
        
        return Output(items: items, request: request, search: search)
    }
}
