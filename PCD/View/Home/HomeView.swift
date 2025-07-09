//
//  HomeView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var isScrolling: Bool
    @Binding var tabBarHeight: CGFloat

    @State private var showDateFilter = false
    @State private var fromDate = Date()
    @State private var toDate = Date()

    @State private var lastScrollOffset: CGFloat = 0
    @State private var fabVisible = true
    @State private var scrollEndTimer: Timer?
    @State private var fabExpanded = false
    @State private var hasAppeared = false
    @State private var isAnimatingFilter = false
    @State private var scrollTrackingEnabled = false
    @State private var cardVisibleIndices: Set<Int> = []

    var onTapSecondaryFAB: () -> Void
    var body: some View {
        ZStack {
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppSpacing.medium) {
                        Color.clear
                            .frame(height: 0)
                            .id("top")  // Anchor for scroll-to-top

                        GreetingCard()

                        if showDateFilter {
                            filterSection
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }

                        if showDateFilter {
                            FilterInfo(fromDate: fromDate, toDate: toDate)
                                .transition(.opacity)
                        }

                        ForEach(sampleCards.indices, id: \.self) { index in
                            HomeCardView(card: sampleCards[index])
                                .opacity(cardVisibleIndices.contains(index) ? 1 : 0)
                                .offset(y: cardVisibleIndices.contains(index) ? 0 : 20)
                                .animation(.easeOut(duration: 0.4).delay(Double(index) * 0.1), value: cardVisibleIndices)
                                .onAppear {
                                    cardVisibleIndices.insert(index)
                                }
                        }
                    }
                    .padding([.horizontal])
                    .padding(.bottom, tabBarHeight + AppSpacing.spacing90)
                    .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0.25), value: showDateFilter)

                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                if !hasAppeared {
                                    hasAppeared = true
                                    lastScrollOffset = geo.frame(in: .global).minY
                                }
                            }
                            .onChange(of: geo.frame(in: .global).minY) { _, newOffset in
                                scrollDidChange(newOffset)
                            }
                    }
                    .frame(height: 0)
                }
                .onChange(of: showDateFilter) { _, newValue in
                    if newValue {
                        withAnimation {
                            scrollProxy.scrollTo("top", anchor: .top)
                        }
                    }
                }
            }

            FloatingActionButton(
                fabExpanded: $fabExpanded,
                showDateFilter: $showDateFilter,
                fabVisible: $fabVisible,
                tabBarHeight: tabBarHeight,
                isAnimatingFilter: $isAnimatingFilter,
                onPrimaryAction: {
                    // Date Filter toggle tapped
                    showDateFilter.toggle()
                },
                onSecondaryAction: {
                    // Secondary FAB tapped — example action:
                    onTapSecondaryFAB()
                }
            )
            .opacity(fabVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: fabVisible)
            .disabled(!fabVisible)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                hasAppeared = true
                scrollTrackingEnabled = true
            }
        }
    }

    var filterSection: some View {
        DateFilterView(
            fromDate: $fromDate,
            toDate: $toDate,
            isAnimatingFilter: $isAnimatingFilter,
            onApply: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isAnimatingFilter = true
                    showDateFilter = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    isAnimatingFilter = false
                }
            },
            onClear: {
                fromDate = Date()
                toDate = Date()
            }, onClose: {
                showDateFilter.toggle()
            }
        )
    }

    private func scrollDidChange(_ offset: CGFloat) {
        guard scrollTrackingEnabled else { return }
        
        // FAB should remain visible while filter is showing or animating
        if isAnimatingFilter || showDateFilter {
            scrollEndTimer?.invalidate()
            lastScrollOffset = offset
            return
        }

        let delta = offset - lastScrollOffset
        scrollEndTimer?.invalidate()

        if delta != 0 {
            if fabVisible {
                withAnimation(.easeInOut(duration: 0.3)) {
                    fabVisible = false
                    isScrolling = true
                }
            }
        }

        scrollEndTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                fabVisible = true
                isScrolling = false
            }
        }

        lastScrollOffset = offset
    }
}


// MARK: - Preview

#Preview {
    PreviewHomeView()
}

private struct PreviewHomeView: View {
    @State private var isScrolling = false
    @State private var tabBarHeight: CGFloat = 0
    
    var body: some View {
        HomeView(isScrolling: $isScrolling, tabBarHeight: $tabBarHeight, onTapSecondaryFAB: {
            
        })
    }
}

