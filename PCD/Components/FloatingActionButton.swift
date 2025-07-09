//
//  FloatingActionButton.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct FloatingActionButton: View {
    @Binding var fabExpanded: Bool
    @Binding var showDateFilter: Bool
    @Binding var fabVisible: Bool
    let tabBarHeight: CGFloat
    @Binding var isAnimatingFilter: Bool

    // Callbacks renamed for clarity
    var onPrimaryAction: (() -> Void)?     // Date Filter Toggle (primary)
    var onSecondaryAction: (() -> Void)?   // Second FAB button (secondary)
    var onMainActionToggle: (() -> Void)? = nil // Main FAB expand/collapse (main)

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                ZStack(alignment: .bottom) {
                    if fabExpanded {
                        VStack(spacing: 16) {
                            // Primary Action Button (Date Filter Toggle)
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isAnimatingFilter = true
                                    onPrimaryAction?()
                                    fabExpanded = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    isAnimatingFilter = false
                                }
                            }) {
                                Image(systemName: showDateFilter ? SystemImages.calendarBadgeMinus : SystemImages.calendarBadgePlus)
                                    .font(.title2)
                                    .padding(AppSpacing.smallMedium)
                                    .background(Circle().fill(AppColors.accentYellow))
                                    .foregroundColor(.black)
                                    .shadow(radius: 4)
                            }

                            // Secondary Action Button
                            Button(action: {
                                onSecondaryAction?()
                                fabExpanded = false
                            }) {
                                Image(systemName: SystemImages.personBadgePlus)
                                    .font(.title2)
                                    .padding(AppSpacing.smallMedium)
                                    .background(Circle().fill(AppColors.accentYellow))
                                    .foregroundColor(.black)
                                    .shadow(radius: 4)
                            }
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 72)
                    }

                    // Main FAB Toggle Button
                    Button(action: {
                        withAnimation {
                            fabExpanded.toggle()
                            onMainActionToggle?()
                        }
                    }) {
                        Image(systemName: SystemImages.plus)
                            .rotationEffect(.degrees(fabExpanded ? 45 : 0))
                            .animation(.easeInOut(duration: 0.3), value: fabExpanded)
                            .font(.title)
                            .padding(AppSpacing.medium)
                            .background(
                                Circle()
                                    .fill(fabExpanded ? AnyShapeStyle(Color.red) : AnyShapeStyle(LinearGradient.appGradient))
                                    .shadow(radius: 10)
                            )
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, tabBarHeight + AppSpacing.medium)
            }
        }
        .zIndex(100)
        .opacity(fabVisible ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: fabVisible)
        .disabled(!fabVisible)
    }
}


struct FloatingActionButtonPreviewContainer: View {
    @State private var fabExpanded = false
    @State private var showDateFilter = false
    @State private var fabVisible = true
    @State private var isAnimatingFilter = false
    @State private var tabBarHeight: CGFloat = 80

    var body: some View {
        VStack {
            FloatingActionButton(
                fabExpanded: $fabExpanded,
                showDateFilter: $showDateFilter,
                fabVisible: $fabVisible,
                tabBarHeight: tabBarHeight,
                isAnimatingFilter: $isAnimatingFilter
            )
            .padding()

            Divider().padding()

            // Controls to toggle FAB states interactively
            Toggle("FAB Visible", isOn: $fabVisible)
            Toggle("Show Date Filter", isOn: $showDateFilter)
            Toggle("FAB Expanded", isOn: $fabExpanded)
            Toggle("Animating Filter", isOn: $isAnimatingFilter)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButtonPreviewContainer()
}
