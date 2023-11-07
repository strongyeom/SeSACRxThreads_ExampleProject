//
//  MovieModel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let movieNm, openDt, salesAmt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten
        case movieNm, openDt, salesAmt
    }
}
