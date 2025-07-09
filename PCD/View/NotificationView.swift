//
//  NotificationView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/06/25.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Coming Soon...")
            .customNavigationBar(title: "Notifications", isGradientBackground: true, isNotificationEnabled: true) {
                dismiss()
            }
    }
}

#Preview {
    NotificationView()
}
