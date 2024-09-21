//
//  APIError.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

enum APIError: Error {
    case unknown
    case invalidURL(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
