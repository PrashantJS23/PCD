//
//  Enums.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
    case home = "house"
    case tracking = "magnifyingglass"
    case work = "tray"

    var title: String {
        switch self {
        case .home: return "Home"
        case .tracking: return "Tracking"
        case .work: return "My Work"
        }
    }
}
