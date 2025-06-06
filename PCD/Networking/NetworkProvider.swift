//
//  NetworkProvider.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Foundation

enum NetworkProvider {
    static func network(forMockFile filename: String) -> NetworkManaging {
        if AppEnvironment.isMock {
            return MockNetworkManager(mockFilename: filename)
        } else {
            return NetworkManager.shared
        }
    }
}
