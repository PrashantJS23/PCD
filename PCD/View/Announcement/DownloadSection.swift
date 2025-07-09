//
//  DownloadSection.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//
import SwiftUI

struct DownloadSection: View {
    let link: String
    @ObservedObject var viewModel: AnnouncementViewModel

    private var fileName: String {
        URL(string: link)?.lastPathComponent ?? "File"
    }

    private var fileURL: URL? {
        URL(string: link)
    }

    private var downloadIcon: some View {
        Group {
            if viewModel.downloadSuccess == true {
                Image(systemName: SystemImages.checkmarkCircleFill)
                    .foregroundColor(.green)
            } else if viewModel.downloadSuccess == false {
                Image(systemName: SystemImages.xmarkCircleFill)
                    .foregroundColor(.red)
            } else {
                Image(systemName: SystemImages.arrowDownCircleFill)
                    .foregroundColor(AppColors.accentYellow)
            }
        }
        .font(.system(size: 22))
        .transition(.scale)
        .animation(.spring(), value: viewModel.downloadSuccess)
    }

    var body: some View {
        Group {
            if let url = fileURL, !link.isEmpty, UIApplication.shared.canOpenURL(url) {
                downloadRow
            }
        }
    }

    private var downloadRow: some View {
        HStack(spacing: 12) {
            if viewModel.isDownloading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: AppColors.accentYellow))
                    .scaleEffect(1.2)
            } else {
                downloadIcon
            }

            Text(fileName)
                .font(.footnote)
                .foregroundColor(AppColors.textPrimaryDark)
                .lineLimit(1)
                .truncationMode(.middle)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if viewModel.downloadSuccess != true && !viewModel.isDownloading {
                viewModel.downloadFile(urlString: link)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.smallMedium))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
