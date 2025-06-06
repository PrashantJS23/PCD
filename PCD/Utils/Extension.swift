//
//  Extension.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//
import SwiftUI

// MARK: - LinearGradient Extension
extension LinearGradient {
    static let appGradient = LinearGradient(
        colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}


extension View {
    func errorOverlay(_ message: String?) -> some View {
        ZStack {
            self
            if let message = message {
//                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                ErrorMessageView(message: message)
                    .padding()
            }
        }
    }
}
