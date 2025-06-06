//
//  AnnouncementCard.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//
import SwiftUI

struct AnnouncementCard: View {
    let announcement: Announcement
    @State private var isVisible = false
    @State private var pulse = false
    @State private var isExpanded = false
    @StateObject private var viewModel = AnnouncementViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack {
                Text(announcement.title)
                    .font(.headline)
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                if announcement.isActive {
                    Text(Strings.newText)
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(AppColors.accentYellow)
                        .cornerRadius(6)
                        .foregroundColor(.black)
                        .scaleEffect(pulse ? 1.1 : 0.95)
                        .animation(
                            .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                            value: pulse
                        )
                        .onAppear { pulse = true }
                }
            }
            
            Text(announcement.description)
                .font(.subheadline)
                .foregroundColor(AppColors.textSecondary)
                .lineLimit(isExpanded ? nil : 3)
                .animation(.easeInOut, value: isExpanded)
        
            // Created At
            Text("\(Strings.createdAtText) \(DateUtil.formatISO8601(announcement.createdAt, dateStyle: .long, timeStyle: .none))")
                .font(.caption2)
                .foregroundColor(AppColors.textSecondary)
            
            // Download Section
            VStack(spacing: AppSpacing.small) {
                DownloadSection(link: announcement.link, viewModel: viewModel)
                // Description with "Show More"/"Show Less"
                if isTextTruncated(announcement.description) {
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded.toggle()
                        }
                    }) {
                        Text(isExpanded ? Strings.showLessButtonTitle : Strings.showMoreButtonTitle)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(AppColors.accentYellow)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: AppColors.shadowColor, radius: 8, x: 0, y: 4)
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
        .animation(.easeOut(duration: 0.5), value: isVisible)
        .padding(.horizontal)
        .onAppear {
            isVisible = true
        }
    }
    
    // Check if description text is longer than ~150 chars to decide showing "Show More"
    private func isTextTruncated(_ text: String) -> Bool {
        return text.count > 150
    }
}

#Preview {
    AnnouncementCard(
        announcement: Announcement(
            id: 1,
            title: "New Feature Released!",
            description: "We're thrilled to launch a major update with new performance improvements and features. Tap below to download the PDF guide. We're thrilled to launch a major update with new performance improvements and features. Tap below to download the PDF guide",
            createdAt: "2025-06-01T09:00:00Z",
            link: "https://example.com/files/sample.pdf",
            isActive: true,
            type: "Update"
        )
    )
}
