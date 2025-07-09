//
//  DashboardCount.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//

import SwiftUI

struct HomeMetrics: Identifiable, Codable {
    var id = UUID()
    let title: String
    let metrics: [DashboardMetric]
    let cardColor: CardColor
}

struct DashboardMetric: Identifiable, Codable {
    var id = UUID()
    let subtitle: String
    let value: String
}

enum CardColor: String, CaseIterable, Codable {
    case indigo, teal, crimson, amber, slate, emerald
    case cerulean, rose, mustard, charcoal, sage, plum, peach, navy, forest, copper

    var color: Color {
        switch self {
        case .indigo:
            return Color(red: 0.29, green: 0.22, blue: 0.43) // Deep Indigo
        case .teal:
            return Color(red: 0.13, green: 0.35, blue: 0.38) // Dark Teal
        case .crimson:
            return Color(red: 0.55, green: 0.13, blue: 0.20) // Deep Crimson
        case .amber:
            return Color(red: 0.93, green: 0.60, blue: 0.13) // Amber
        case .slate:
            return Color(red: 0.44, green: 0.50, blue: 0.56) // Slate Gray
        case .emerald:
            return Color(red: 0.25, green: 0.51, blue: 0.47) // Emerald Green
        case .cerulean:
            return Color(red: 0.00, green: 0.48, blue: 0.65) // Cerulean Blue
        case .rose:
            return Color(red: 0.76, green: 0.14, blue: 0.34) // Rich Rose
        case .mustard:
            return Color(red: 0.82, green: 0.67, blue: 0.17) // Mustard Yellow
        case .charcoal:
            return Color(red: 0.21, green: 0.27, blue: 0.31) // Charcoal Gray
        case .sage:
            return Color(red: 0.60, green: 0.68, blue: 0.55) // Sage Green
        case .plum:
            return Color(red: 0.39, green: 0.16, blue: 0.28) // Deep Plum
        case .peach:
            return Color(red: 1.00, green: 0.80, blue: 0.68) // Soft Peach
        case .navy:
            return Color(red: 0.10, green: 0.15, blue: 0.30) // Dark Navy
        case .forest:
            return Color(red: 0.13, green: 0.35, blue: 0.13) // Forest Green
        case .copper:
            return Color(red: 0.72, green: 0.45, blue: 0.20) // Copper
        }
    }
}

let sampleCards: [HomeMetrics] = [
    HomeMetrics(
        title: "Total Request",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.indigo
    ),
    HomeMetrics(
        title: "Pending Acceptance",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.teal
    ),
    HomeMetrics(
        title: "Pending BU",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.crimson
    ),
    HomeMetrics(
        title: "Pending Logistic PIC",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.amber
    ),
    HomeMetrics(
        title: "Pending Clerk",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.slate
    ),
    HomeMetrics(
        title: "Pending Vendor",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.emerald
    ),
    HomeMetrics(
        title: "Cancel Request",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Acceptance Stage", value: "\(Int.random(in: 20..<50))"),
            DashboardMetric(subtitle: "Job Execution Stage", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.charcoal
    ),
    HomeMetrics(
        title: "Payment Done",
        metrics: [
            DashboardMetric(subtitle: "NON STO", value: "RM 0.\(Int.random(in: 20..<50)) M"),
            DashboardMetric(subtitle: "Freight", value: "RM 0.\(Int.random(in: 20..<50)) M")
        ],
        cardColor: CardColor.cerulean
    )
]
