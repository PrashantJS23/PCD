//
//  MockNetworkManager.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Combine
import Foundation

final class MockNetworkManager: NetworkManaging {
    var mockFilename: String

    init(mockFilename: String) {
        self.mockFilename = mockFilename
    }

    func get<T: Decodable>(urlString: String, headers: [String: String]? = nil) -> AnyPublisher<T, NetworkError> {
        guard let url = Bundle.main.url(forResource: mockFilename, withExtension: "json") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return Just(decoded)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .decodingError).eraseToAnyPublisher()
        }
    }

    func post<T: Decodable, U: Encodable>(
        urlString: String,
        body: U,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, NetworkError> {
        // Simulate POST by reusing GET
        return get(urlString: urlString, headers: headers)
    }

    func downloadFile(from urlString: String) -> AnyPublisher<URL, NetworkError> {
        // Return mock file URL or Fail if not needed
        return Fail(error: NetworkError.custom("Mock download not implemented"))
            .eraseToAnyPublisher()
    }
}
