//
//  NetworkError.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failedToEncode
    case failedToDecode
    case invalidResponse
    case invalidData
}
