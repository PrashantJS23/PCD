//
//  Colors.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//
import SwiftUI

enum AppColors {
    static let primaryGradientStart = Color(red: 32 / 255, green: 33 / 255, blue: 77 / 255)
    static let primaryGradientEnd = Color(red: 24 / 255, green: 66 / 255, blue: 103 / 255)
    static let buttonBackground = Color.yellow
    static let buttonForeground = Color.black
    static let textPrimaryDark = Color.white
    static let textSecondaryDark = Color.white.opacity(0.75)
    static let textPrimaryLight = Color.primary
    static let textSecondaryLight = Color.primary.opacity(0.75)
    static let navBarBackground = Color(red: 28 / 255, green: 50 / 255, blue: 90 / 255).opacity(0.8)
    static let cardBackground = Color(red: 8 / 255, green: 23 / 255, blue: 54 / 255)
    static let accentYellow = Color(red: 255 / 255, green: 204 / 255, blue: 77 / 255)
    static let shadowColor = Color.black.opacity(0.3)

    static let inputBackground = Color(.systemGray6)
    static let inputBorder = Color.gray.opacity(0.3)
    static let buttonShadow = Color.blue.opacity(0.15)
    static let dropdownSelection = Color.blue.opacity(0.1)
    static let overlayBackground = Color.black.opacity(0.25)
    static let floatingBarBackground = Color.white
    static let systemGroupedBackground = Color(.systemGroupedBackground)
}
