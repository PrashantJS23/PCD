//
//  AnnoucementView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct AnnouncementView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        GradientBackgroundView {
            Text("Announcements coming soon...")
                .foregroundColor(.white)
        }
        .customNavigationBar(title: "Announcements") { dismiss() }
    }
}


#Preview {
    AnnouncementView()
}
