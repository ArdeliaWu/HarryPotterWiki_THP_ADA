//
//  ErrorHandling.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}


