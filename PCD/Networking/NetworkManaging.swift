//
//  NetworkManaging.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Foundation
import Combine

protocol NetworkManaging {
    func get<T: Decodable>(
        urlString: String,
        headers: [String: String]?
    ) -> AnyPublisher<T, NetworkError>

    func post<T: Decodable, U: Encodable>(
        urlString: String,
        body: U,
        headers: [String: String]?
    ) -> AnyPublisher<T, NetworkError>
    
    func downloadFile(
        from urlString: String
    ) -> AnyPublisher<URL, NetworkError>
}

extension NetworkManaging {
    func get<T: Decodable>(
        urlString: String
    ) -> AnyPublisher<T, NetworkError> {
        return get(urlString: urlString, headers: nil)
    }

    func post<T: Decodable, U: Encodable>(
        urlString: String,
        body: U
    ) -> AnyPublisher<T, NetworkError> {
        return post(urlString: urlString, body: body, headers: nil)
    }
}
