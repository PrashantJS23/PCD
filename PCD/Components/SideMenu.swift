//
//  SideMenu.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var appState: AppState
    var onSelectTab: (Tab) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.huge) {

            // MARK: - Header
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                Image(systemName: SystemImages.personCircleFill)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: AppSizes.sideMenuProfileImageSize,
                           height: AppSizes.sideMenuProfileImageSize)
                    .foregroundColor(.white)

                Text(AppText.sideMenuGreetingText)
                    .font(.headline)
                    .foregroundColor(.white)
            }

            Divider()
                .background(Color.white.opacity(0.4))

            // MARK: - Navigation Tabs
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        onSelectTab(tab)
                    } label: {
                        HStack(spacing: AppSpacing.medium) {
                            Image(systemName: tab.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: AppSizes.sideMenuIconSize,
                                       height: AppSizes.sideMenuIconSize)

                            Text(tab.title)
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, AppSpacing.small)
                    }
                }
            }

            Spacer()

            Divider()
                .background(Color.white.opacity(0.4))

            // MARK: - Logout
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                Button {
                    appState.isLoggedIn = false
                } label: {
                    HStack(spacing: AppSpacing.medium) {
                        Image(systemName: SystemImages.power)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: AppSizes.sideMenuIconSize,
                                   height: AppSizes.sideMenuIconSize)
                            .foregroundColor(.yellow)

                        Text(AppText.logoutButton)
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .padding(.horizontal, AppSpacing.mediumLarge)
        .safeAreaPadding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    SideMenu { _ in }
}
