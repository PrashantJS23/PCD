//
//  AppState.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

import SwiftUI
import Foundation

enum AppStorageKeys {
    static let isLoggedIn = "isLoggedIn"
}

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: AppStorageKeys.isLoggedIn)
        }
    }

    init() {
        // Always read the persisted value at startup
        self.isLoggedIn = UserDefaults.standard.bool(forKey: AppStorageKeys.isLoggedIn)
    }

    func logout() {
        isLoggedIn = false
    }
}
