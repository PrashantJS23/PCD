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

    var body: some View {
        if let url = URL(string: link),
           !link.isEmpty,
           UIApplication.shared.canOpenURL(url) {
            HStack(spacing: 12) {
                if viewModel.isDownloading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: AppColors.accentYellow))
                        .scaleEffect(1.2)
                } else {
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

                Text(fileName)
                    .font(.footnote)
                    .foregroundColor(AppColors.textPrimary)
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
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

