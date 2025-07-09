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
    @State private var isNotificationOpen = false
    @State private var isScrolling = false
    @State private var tabBarHeight: CGFloat = 0
    @State private var navigateTo: Bool = false

    init(showHomeTab: Binding<Bool>) {
        _showHomeTab = showHomeTab
        _selectedTab = State(initialValue: showHomeTab.wrappedValue ? .home : .work)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                // Top gradient bar
                LinearGradient.appGradient
                    .frame(height: AppSizes.topBarHeight)
                    .edgesIgnoringSafeArea(.top)

                // Main content area
                VStack(spacing: 0) {
                    CustomTopBar(isMenuOpen: $isMenuOpen, isNotificationOpen: $isNotificationOpen)

                    ContentViewSwitcher(
                        selectedTab: selectedTab,
                        isScrolling: $isScrolling,
                        tabBarHeight: $tabBarHeight,
                        navigateTo: $navigateTo
                    )
                }
                .disabled(isMenuOpen)
                .blur(radius: isMenuOpen ? 3 : 0)
                .zIndex(0)

                // Tab bar at bottom
                VStack {
                    Spacer()
                    TabBar(
                        selectedTab: $selectedTab,
                        visibleTabs: visibleTabs,
                        animation: animation
                    )
                    .opacity(isScrolling ? 0 : 1)
                    .offset(y: isScrolling ? 100 : 0)
                    // Use withAnimation block on state changes instead of .animation here
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear { tabBarHeight = proxy.size.height }
                                .onChange(of: proxy.size.height) { _, newValue in tabBarHeight = newValue }
                        }
                    )
                }
                .zIndex(1)

                // Dimmed background overlay when menu is open
                if isMenuOpen {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isMenuOpen = false
                            }
                        }
                        .zIndex(2)
                }

                // Side Menu with slide-in animation
                SideMenuWrapper(isMenuOpen: $isMenuOpen, selectedTab: $selectedTab)
                    .frame(width: AppSizes.sideMenuWidth)
                    .zIndex(3)

            }
            // Navigation triggered by boolean binding
            .navigationDestination(isPresented: $isNotificationOpen, destination: {
                NotificationView()
            })
            .navigationDestination(isPresented: $navigateTo) {
                switch selectedTab {
                case .home:
                    VendorPerformanceView()
                case .tracking:
                    TrackingDetailsView()
                case .work:
                    MyWorkDetailsView()
                }
            }
        }
    }

    // Helper computed property for visible tabs
    private var visibleTabs: [Tab] {
        var tabs: [Tab] = [.tracking, .work]
        if showHomeTab {
            tabs.insert(.home, at: 0)
        }
        return tabs
    }
}

// MARK: - SideMenu wrapper with animation & tab selection
private struct SideMenuWrapper: View {
    @Binding var isMenuOpen: Bool
    @Binding var selectedTab: Tab

    var body: some View {
        SideMenu(onSelectTab: { tab in
            withAnimation(.easeOut) {
                selectedTab = tab
                isMenuOpen = false
            }
        })
        .offset(x: isMenuOpen ? 0 : -AppSizes.sideMenuWidth)
        .animation(.easeOut(duration: 0.3), value: isMenuOpen)
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
