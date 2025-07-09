//
//  TrackingDetails.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/06/25.
//

import SwiftUI

struct TrackingDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Coming Soon...")
            .customNavigationBar(title: "Tracking Details", isGradientBackground: true) {
                dismiss()
            }
    }
}

#Preview {
    TrackingDetailsView()
}
