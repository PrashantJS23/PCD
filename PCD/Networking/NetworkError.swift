//
//  NetworkError.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
    case custom(String)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data was returned from the server."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .serverError(let code):
            return "Server returned an error. Status code: \(code)"
        case .unknown(let error):
            return error.localizedDescription
        case .invalidResponse:
            return "Invalid server response."
        case .custom(let message):
            return message
        }
    }
}
