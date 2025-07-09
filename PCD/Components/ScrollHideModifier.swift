//
//  ScrollHideModifier.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/06/25.
//

import SwiftUI

struct ScrollHideModifier: ViewModifier {
    @Binding var isScrolling: Bool

    @State private var lastOffset: CGFloat = 0
    @State private var scrollEndTimer: Timer?
    @State private var scrollTrackingEnabled = false
    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            if !hasAppeared {
                                hasAppeared = true
                                lastOffset = geo.frame(in: .global).minY
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    scrollTrackingEnabled = true
                                }
                            }
                        }
                        .onChange(of: geo.frame(in: .global).minY) { _, newOffset in
                            handleScroll(newOffset)
                        }
                }
                .frame(height: 0)
            )
    }

    private func handleScroll(_ newOffset: CGFloat) {
        guard scrollTrackingEnabled else { return }

        let delta = newOffset - lastOffset
        scrollEndTimer?.invalidate()

        if abs(delta) > 2 {
            withAnimation(.easeInOut(duration: 0.3)) {
                isScrolling = true
            }
        }

        scrollEndTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                isScrolling = false
            }
        }

        lastOffset = newOffset
    }
}
