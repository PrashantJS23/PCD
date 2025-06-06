//
//  Environment.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

enum AppEnvironment {
    enum Mode {
        case mock
        case staging
        case production
    }

    // 🛠 Change this to switch environments manually
    static var current: Mode = .mock

    // Convenience flags
    static var isMock: Bool { current == .mock }
    static var isStaging: Bool { current == .staging }
    static var isProduction: Bool { current == .production }
}
