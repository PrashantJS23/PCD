//
//  ContentViewSwitcher.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct ContentViewSwitcher: View {
    let selectedTab: Tab
    @Binding var isScrolling: Bool
    @Binding var tabBarHeight: CGFloat
    @Binding var navigateTo: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView(isScrolling: $isScrolling, tabBarHeight: $tabBarHeight) {
                        self.navigateTo = true
                    }
                case .tracking:
                    TrackingView(isScrolling: $isScrolling, tabBarHeight: $tabBarHeight) {
                        self.navigateTo = true
                    }
                case .work:
                    MyWorkView(isScrolling: $isScrolling, tabBarHeight: $tabBarHeight) {
                        self.navigateTo = true
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
