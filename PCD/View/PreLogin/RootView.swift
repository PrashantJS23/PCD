//
//  RootSwitcherView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isLoggedIn {
                HomeNavigationStack()
            } else {
                OnboardingNavigationStack()
            }
        }
    }
}

#Preview {
    RootView().environmentObject(AppState())
}

struct OnboardingNavigationStack: View {
    var body: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}

struct HomeNavigationStack: View {
    @State private var showHomeTab = true  

    var body: some View {
        NavigationStack {
            MainView(showHomeTab: $showHomeTab)
        }
    }
}
