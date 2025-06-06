//
//  HomeView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct MainView: View {
    @Binding var showHomeTab: Bool
    @State private var selectedTab: Tab = .work
    @Namespace private var animation
    @State private var isMenuOpen = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background gradient behind top bar
            LinearGradient.appGradient
                .frame(height: AppSizes.topBarHeight)
                .edgesIgnoringSafeArea(.top)

            // Main content stack
            VStack(spacing: 0) {
                customTopBar // Custom nav bar
                contentView
                tabBar
            }
            .disabled(isMenuOpen)
            .blur(radius: isMenuOpen ? 3 : 0)
            .zIndex(0)

            // Dim overlay when menu is open
            if isMenuOpen {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }
                    .zIndex(1)
            }

            SideMenu(onSelectTab: { tab in
                withAnimation {
                    selectedTab = tab
                    isMenuOpen = false
                }
            })
            .frame(width: AppSizes.sideMenuWidth)
            .offset(x: isMenuOpen ? 0 : -AppSizes.sideMenuWidth)
            .animation(.easeOut(duration: 0.3), value: isMenuOpen)
            .zIndex(2)
        }
    }

    // MARK: - Subviews

    private var contentView: some View {
        ZStack {
            switch selectedTab {
            case .home: HomeView()
            case .tracking: TrackingView()
            case .work: MyWorkView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var customTopBar: some View {
        GeometryReader { geometry in
            let topInset = geometry.safeAreaInsets.top

            HStack {
                Button {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                } label: {
                    Image(systemName: SystemImages.lineHorizontalDecrease)
                        .resizable()
                        .scaledToFit()
                        .frame(width: AppSizes.menuIconWidth, height: AppSizes.menuIconHeight)
                        .foregroundColor(.white)
                }

                Spacer()

                Image(AssetImages.pcdLogoWhite)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: AppSizes.logoHeight)
                    .padding(AppSpacing.extraSmall)

                Spacer()

                Image(systemName: SystemImages.bellFill)
                    .resizable()
                    .scaledToFit()
                    .frame(width: AppSizes.menuIconWidth, height: AppSizes.menuIconHeight)
                    .foregroundColor(.white)
            }
            .padding(.top, topInset)
            .padding(.horizontal)
            .frame(height: topInset + AppSizes.topBarContentHeight)
            .background(LinearGradient.appGradient)
            .ignoresSafeArea(edges: .top)
        }
        .frame(height: AppSizes.topBarHeight)
    }

    private var tabBar: some View {
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
                            .foregroundColor(selectedTab == tab ? Color.white : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppSpacing.small)
                }
            }
        }
        .background(LinearGradient.appGradient)
        .clipShape(Capsule())
        .shadow(radius: 5)
        .padding(.horizontal)
    }

    var visibleTabs: [Tab] {
        var tabs: [Tab] = [.tracking, .work]
        if showHomeTab {
            tabs.insert(.home, at: 0)
        }
        return tabs
    }
}

// MARK: - Preview

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var showHomeTab = true

    var body: some View {
        MainView(showHomeTab: $showHomeTab)
    }
}
