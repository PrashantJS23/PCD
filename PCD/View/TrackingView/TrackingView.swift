//
//  TrackingView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//

import SwiftUI

struct TrackingView: View {
    
    @State private var selectedOption: TrackingOption = .nonSTO
    @State private var showSecondOption = true
    
    @State private var fromDate = Date()
    @State private var toDate = Date()
    @State private var fromDateText = ""
    @State private var toDateText = ""
    
    @State private var unloadFromDate = Date()
    @State private var unloadToDate = Date()
    @State private var unloadFromDateText = ""
    @State private var unloadToDateText = ""
    
    @State private var showDatePicker = false
    @State private var dateBeingEdited: Binding<Date>?
    @State private var dateTextBeingEdited: Binding<String>?
    
    @State private var selected: DropdownOption? = nil
    @State private var isExpanded = false
    
    @State private var value = ""
    @State private var animateContent = false
    
    @Binding var isScrolling: Bool
    @Binding var tabBarHeight: CGFloat
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var onSearchTap: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: AppSpacing.medium) {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: AppSpacing.medium) {
                        headerText
                        trackingOptions
                        datePickersGroup
                        dropdownPicker
                        searchSection
                    }
                    .padding()
                    .background(Color.white, in: RoundedRectangle(cornerRadius: AppRadius.small))
                    .shadow(color: .black.opacity(0.06), radius: AppSizes.shadowRadius, x: 0, y: 8)
                    .padding([.top, .horizontal])
                    .padding(.bottom, tabBarHeight)
                    .onAppear { animateContent = true }
                }
            }
            floatingInstructions
        }
        .background(AppColors.systemGroupedBackground.ignoresSafeArea())
        .overlay(datePickerOverlay)
    }
    
    // MARK: - Components
    
    private var headerText: some View {
        Text(AppText.noSearchParametersSelectedText)
            .font(.headline)
            .foregroundColor(AppColors.textPrimaryLight)
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 30)
            .animation(.easeOut(duration: 0.6).delay(0.1), value: animateContent)
    }
    
    private var trackingOptions: some View {
        HStack(spacing: 12) {
            ForEach(TrackingOption.allCases, id: \.self) { option in
                Group {
                    if option != .freight || showSecondOption {
                        RadioButton(label: option.rawValue, value: option, selected: $selectedOption)
                            .scaleEffect(selectedOption == option ? 1.05 : 1)
                    }
                }
            }
        }
        .animation(.spring(), value: selectedOption)
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 30)
    }
    
    private var datePickersGroup: some View {
        Group {
            DateRangePickerField(
                title: AppText.loadingDateRange,
                fromDate: $fromDate,
                toDate: $toDate,
                fromDateText: $fromDateText,
                toDateText: $toDateText,
                onFromTap: {
                    dateBeingEdited = $fromDate
                    dateTextBeingEdited = $fromDateText
                    withAnimation { showDatePicker = true }
                },
                onToTap: {
                    dateBeingEdited = $toDate
                    dateTextBeingEdited = $toDateText
                    withAnimation { showDatePicker = true }
                }
            )
            DateRangePickerField(
                title: AppText.unloadingDateRange,
                fromDate: $unloadFromDate,
                toDate: $unloadToDate,
                fromDateText: $unloadFromDateText,
                toDateText: $unloadToDateText,
                onFromTap: {
                    dateBeingEdited = $unloadFromDate
                    dateTextBeingEdited = $unloadFromDateText
                    withAnimation { showDatePicker = true }
                },
                onToTap: {
                    dateBeingEdited = $unloadToDate
                    dateTextBeingEdited = $unloadToDateText
                    withAnimation { showDatePicker = true }
                }
            )
        }
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 30)
        .animation(.easeOut(duration: 0.6).delay(0.18), value: animateContent)
    }
    
    private var dropdownPicker: some View {
        ZStack {
            DropdownPicker(
                placeholder: AppText.chooseOption,
                items: AppList.options,
                selectedItem: $selected,
                isExpanded: $isExpanded,
                label: {
                    AnyView(
                        HStack {
                            Text(selected?.title ?? AppText.chooseOption)
                                .fontWeight(.medium)
                            Spacer()
                            Image(systemName: isExpanded ? SystemImages.chevronUp : SystemImages.chevronDown)
                        }
                        .inputStyle()
                    )
                },
                rowView: { option, isSelected in
                    AnyView(
                        HStack {
                            Text(option.title)
                                .fontWeight(isSelected ? .bold : .regular)
                                .foregroundColor(.black)
                            Spacer()
                            if isSelected {
                                Image(systemName: SystemImages.checkmark).foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(isSelected ? AppColors.inputBackground : Color.white)
                    )
                }
            )
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.spring(), value: isExpanded)
            
            if isExpanded {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isExpanded = false }
                    }
            }
        }
        .zIndex(2)
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 30)
        .animation(.easeOut(duration: 0.6).delay(0.23), value: animateContent)
    }
    
    private var searchSection: some View {
        HStack(spacing: AppSpacing.small) {
            CustomTextField(
                text: $value,
                placeholder: AppText.searchPlaceholder,
                foregroundColor: .black,
                backgroundColor: AppColors.inputBackground
            )
            .inputStyle()
            
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onSearchTap()
            } label: {
                HStack {
                    Image(systemName: SystemImages.magnifyingglass)
                    Text(AppText.searchButton)
                        .fontWeight(.semibold)
                }
            }
            .primaryButtonStyle()
            .scaleOnTap()
        }
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 30)
        .animation(.easeOut(duration: 0.6).delay(0.3), value: animateContent)
    }
    
    private var floatingInstructions: some View {
        VStack {
            Spacer()
            Text(AppText.trackingInstructionsText)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.textPrimaryLight)
                .padding(.horizontal, AppSizes.padding)
                .padding(.vertical, AppSpacing.small)
                .background(AppColors.floatingBarBackground, in: Capsule())
                .shadow(color: .black.opacity(0.06), radius: AppSizes.shadowRadius, x: 0, y: 8)
                .padding(.bottom, tabBarHeight + 24)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: tabBarHeight)
        }
    }
    
    private var datePickerOverlay: some View {
        Group {
            if showDatePicker, let dateBinding = dateBeingEdited, let textBinding = dateTextBeingEdited {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showDatePicker = false }
                    }
                
                VStack {
                    DatePicker(AppText.selectDateText, selection: dateBinding, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                    
                    Button(AppText.doneText) {
                        withAnimation {
                            textBinding.wrappedValue = dateFormatter.string(from: dateBinding.wrappedValue)
                            showDatePicker = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .background(.regularMaterial)
                .cornerRadius(AppRadius.large)
                .padding()
                .shadow(radius: AppSizes.shadowRadius)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: showDatePicker)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PreviewTrackingView()
}

private struct PreviewTrackingView: View {
    @State private var isScrolling = false
    @State private var tabBarHeight: CGFloat = 0
    
    var body: some View {
        TrackingView(isScrolling: $isScrolling, tabBarHeight: $tabBarHeight) {
            // search tap action here
        }
    }
}

