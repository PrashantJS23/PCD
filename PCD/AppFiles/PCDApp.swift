//
//  PCDApp.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 27/05/25.
//

import SwiftData
import SwiftUI

@main
struct PCDApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
