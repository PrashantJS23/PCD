//
//  APIConstants.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Foundation

struct APIConstants {
    static var baseURL: String {
        switch AppEnvironment.current {
        case .production:
            return "https://api.example.com"
        case .staging:
            return "https://staging.api.example.com"
        case .mock:
            return "https://api.example.com"
        }
    }

    struct Endpoints {
        static let announcements = "/api/v1/announcements"
        static let feedback = "/api/v1/feedback"
        static let userProfile = "/api/v1/user/profile"
    }

    static func fullURL(for endpoint: String) -> String {
        return baseURL + endpoint
    }
}
