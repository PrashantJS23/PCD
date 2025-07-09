//
//  TabBar.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Tab
    let visibleTabs: [Tab]
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(visibleTabs, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: AppSpacing.extraSmall) {
                        ZStack {
                            if selectedTab == tab {
                                Circle()
                                    .fill(Color.white)
                                    .frame(maxHeight: AppSizes.tabBubbleSize)
                                    .matchedGeometryEffect(id: "bubble", in: animation)
                            }
                            Image(systemName: tab.rawValue)
                                .font(.system(size: AppSizes.tabIconSize))
                                .foregroundColor(selectedTab == tab ? AppColors.primaryGradientStart : .gray)
                        }
                        Text(tab.title)
                            .font(Fonts.small)
                            .fontWeight(selectedTab == tab ? .bold : .regular)
                            .foregroundColor(selectedTab == tab ? .white : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppSpacing.small)
                }
            }
        }
        .background(
            Capsule()
                .fill(LinearGradient.appGradient)
                .shadow(color: .black.opacity(0.5), radius: 10)
        )
        .padding(.horizontal)
    }
}
