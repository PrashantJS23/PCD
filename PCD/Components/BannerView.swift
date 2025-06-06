//
//  ErrorBannerView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

enum BannerType {
    case success
    case error
    case warning

    var backgroundColor: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        }
    }

    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.bubble.fill"
        case .error: return "exclamationmark.triangle.fill"
        }
    }
}

struct BannerView: View {
    let message: String
    let type: BannerType
    var onClose: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: type.iconName)
                .foregroundColor(.white)

            Text(message)
                .foregroundColor(.white)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            Spacer()

            Button(action: onClose) {
                Image(systemName: SystemImages.xmarkCircleFill)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .background(type.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 4)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    BannerView(message: "Something went wrong!", type: .warning, onClose: {})
}
