//
//  NetworkManager.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Combine
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    // MARK: - Generic Request

    func request<T: Decodable, U: Encodable>(
        urlString: String,
        method: HTTPMethod,
        body: U? = nil,
        headers: [String: String]? = nil,
    ) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(HTTPHeader.Value.json, forHTTPHeaderField: HTTPHeader.contentType)

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return Fail(error: NetworkError.unknown(error)).eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.noData
                }

                guard (200 ... 299).contains(response.statusCode) else {
                    throw NetworkError.serverError(statusCode: response.statusCode)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let netErr = error as? NetworkError {
                    return netErr
                } else if error is DecodingError {
                    return .decodingError
                } else {
                    return .unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkManager: NetworkManaging {
    // MARK: - GET

    func get<T: Decodable>(
        urlString: String,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, NetworkError> {
        request(
            urlString: urlString,
            method: .get,
            body: Data?.none,
            headers: headers
        )
    }

    // MARK: - POST

    func post<T: Decodable, U: Encodable>(
        urlString: String,
        body: U,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, NetworkError> {
        request(
            urlString: urlString,
            method: .post,
            body: body,
            headers: headers
        )
    }

    func downloadFile(from urlString: String) -> AnyPublisher<URL, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return Future<URL, NetworkError> { promise in
            let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
                if let error = error {
                    promise(.failure(.custom(error.localizedDescription)))
                    return
                }

                guard
                    let tempURL = tempURL,
                    let httpResponse = response as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode
                else {
                    promise(.failure(.invalidResponse))
                    return
                }

                do {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)
                    // Remove existing file if exists
                    if FileManager.default.fileExists(atPath: destinationURL.path) {
                        try FileManager.default.removeItem(at: destinationURL)
                    }
                    try FileManager.default.copyItem(at: tempURL, to: destinationURL)
                    promise(.success(destinationURL))
                } catch {
                    promise(.failure(.custom(error.localizedDescription)))
                }
            }
            task.resume()
        }
        .eraseToAnyPublisher()
    }
}
