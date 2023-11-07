//
//  MovieAPIManager.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import Foundation
import RxSwift

enum MovieAPIError: Error {
    case unkowned
    case statusError
}

class MovieAPIManager {
    static func request(date: Int) -> Observable<MovieModel> {
        
        return Observable<MovieModel>.create { value in
            let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=450cb2fb7a3b7636f780cc8065fb7a8d&targetDt=\(date)"
            
            guard let url = URL(string: urlString) else {
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let _ = error {
                    value.onError(MovieAPIError.unkowned)
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(MovieAPIError.unkowned)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                    print("URL 성공")
                    value.onNext(appData)
                }
            }
            .resume()
            
            return Disposables.create()
        }
    }
}
