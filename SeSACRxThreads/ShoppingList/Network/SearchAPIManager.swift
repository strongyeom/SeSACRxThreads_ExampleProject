//
//  SearchAPIManager.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
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
                
                // 네트워크 통신으로 가져온 data를 SearchAppModel 타입으로 decoding 하는 작업
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
                
            }.resume()
            
            return Disposables.create()
        }
    }
    
    static func request() -> Observable<SearchAppModel> {
        
       
        return Observable<SearchAppModel>.create { value in
            
            let urlString = "https://itunes.apple.com/search?term=todo&country=KR&media=software&lang=ko_KR&limit=10"
            
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invalidURL)
                return  Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession ㅏㅓㅏㅓㅏ")
                if let _ = error {
                    print("URLSession error")
                    value.onError(APIError.unkwoned)
                   
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("URLSession response")
                    value.onError(APIError.statusError)
                    
                    return
                }
                
                guard let data else {
                    print("data----- error")
                    return
                }
                
                do {
                    let appData = try JSONDecoder().decode(SearchAppModel.self, from: data)
                    value.onNext(appData)
                } catch {
                    print(error.localizedDescription)
                    
                }
               
                
            }.resume()
            return Disposables.create()
        }
    }
}
