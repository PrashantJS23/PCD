//
//  AnnoucementView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct AnnouncementView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AnnouncementViewModel()

    var body: some View {
        GradientBackgroundView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: AppSpacing.mediumLarge) {
                    ForEach(viewModel.announcements) { announcement in
                        AnnouncementCard(announcement: announcement)
                            .environmentObject(viewModel)
                    }
                }
                .padding(.vertical)
            }
        }
        .customNavigationBar(title: Strings.announcementScreenTitle) { dismiss() }
        .errorOverlay(viewModel.errorMessage)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadAnnouncement()
        }
    }
}

#Preview {
    AnnouncementView()
}
