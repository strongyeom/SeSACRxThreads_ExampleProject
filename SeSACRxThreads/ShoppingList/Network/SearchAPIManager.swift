//
//  SearchAPIManager.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import Foundation
import RxSwift

enum APIError : Error {
    case unkwoned
    case statusError
}

class SearchAPIManager {
    static func requestSearch(searchString: String) -> Observable<SearchAppModel> {
        
       
        return Observable<SearchAppModel>.create { value in
            
            let url = "https://itunes.apple.com/search?term=\(searchString)&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: url) else {
                return  Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession Succeess")
                if let _ = error {
                    value.onError(APIError.unkwoned)
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
                
            }.resume()
            return Disposables.create()
        }
    }
    
    static func request() -> Observable<SearchAppModel> {
        
       
        return Observable<SearchAppModel>.create { value in
            
            let url = "https://itunes.apple.com/search?term=todo&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: url) else {
                return  Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession Succeess")
                if let _ = error {
                    value.onError(APIError.unkwoned)
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
                
            }.resume()
            return Disposables.create()
        }
    }
}
