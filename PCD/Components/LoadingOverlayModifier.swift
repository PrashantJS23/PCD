//
//  LoadingOverlayModifier.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct LoadingOverlayModifier: ViewModifier {
    var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoaderView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

extension View {
    func loadingOverlay(_ isLoading: Bool) -> some View {
        self.modifier(LoadingOverlayModifier(isLoading: isLoading))
    }
}
