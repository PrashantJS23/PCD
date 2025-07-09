//
//  MyWorkView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

import SwiftUI

struct MyWorkView: View {
    @State private var searchText: String = ""
    @Binding var isScrolling: Bool
    @Binding var tabBarHeight: CGFloat
    @State private var selectedSegment: Int = 0
    
    var onCardTap: () -> Void
    let segmentOptions = ["MW", "WB"]
    
    var body: some View {
        ZStack {
            AppColors.systemGroupedBackground
                .ignoresSafeArea()
            
            VStack(spacing: AppSpacing.medium) {
                
                // Search Field
                searchField
                
                // Header with title and segmented picker
                headerSegment
                
                // Content list with cards
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: AppSpacing.medium) {
                        ForEach(0..<4, id: \.self) { index in
                            MyWorkCardView(index: index, onButtonTap: onCardTap)
                                .transition(.scale)
                                .animation(.easeInOut(duration: 0.3), value: selectedSegment)
                        }
                    }
                    .padding(.bottom, tabBarHeight + AppSpacing.medium)
                    .hideTabBarOnScroll(isScrolling: $isScrolling)
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    private var searchField: some View {
        CustomTextField(
            text: $searchText,
            placeholder: AppText.myWorkSearchPlaceholder,
            prefixIcon: SystemImages.magnifyingglass,
            foregroundColor: AppColors.textPrimaryLight,
            backgroundColor: .white
        )
        .background(
            RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
    
    private var headerSegment: some View {
        HStack {
            Text("Pending Action (100)")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            CustomSegmentedPicker(
                selectedIndex: $selectedSegment,
                options: segmentOptions,
                selectedColor: .white,
                selectedTextColor: .primary,
                unselectedTextColor: .white,
                backgroundColor: AppColors.cardBackground,
                minSegmentWidth: 30,
                verticalPadding: 6,
                horizontalPadding: 12
            )
            .padding(.vertical, AppSpacing.small)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                .fill(Color(AppColors.dropdownSelection))
                .shadow(color: AppColors.cardBackground.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - Preview

struct MyWorkView_Previews: PreviewProvider {
    @State static var isScrolling = false
    @State static var tabBarHeight: CGFloat = 0
    
    static var previews: some View {
        MyWorkView(
            isScrolling: $isScrolling,
            tabBarHeight: $tabBarHeight,
            onCardTap: { print("Card tapped!") }
        )
    }
}

