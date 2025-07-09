//
//  CustomDropdown.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 12/06/25.
//

import SwiftUI

/// Generic dropdown item protocol
protocol DropdownItem: Identifiable, Hashable, CustomStringConvertible {}

/// Example conforming type
struct DropdownOption: DropdownItem {
    let id = UUID()
    let title: String
    
    var description: String { title }
}

/// Reusable & Dynamic Dropdown Picker
struct DropdownPicker<Item: DropdownItem, Label: View, RowView: View>: View {
    // MARK: Properties
    let placeholder: String
    let items: [Item]
    @Binding var selectedItem: Item?
    @Binding var isExpanded: Bool
    
    var dismissHandler: (() -> Void)? = nil
    var label: (() -> Label)? = nil
    var rowView: ((Item, Bool) -> RowView)? = nil
    
    // MARK: Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Main dropdown button or custom label
            Group {
                if let label = label {
                    Button(action: { withAnimation { isExpanded.toggle() } }) {
                        label()
                    }
                } else {
                    Button(action: { withAnimation { isExpanded.toggle() } }) {
                        HStack {
                            Text(selectedItem?.description ?? placeholder)
                                .foregroundColor(selectedItem == nil ? .gray : .primary)
                            Spacer()
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.separator), lineWidth: 1)
                        )
                    }
                }
            }
            // Present dropdown as an overlay
            .overlay(
                Group {
                    if isExpanded {
                        VStack(spacing: 0) {
                            ForEach(items) { item in
                                let isSelected = item == selectedItem
                                Button(action: {
                                    withAnimation {
                                        selectedItem = item
                                        isExpanded = false
                                        dismissHandler?()
                                    }
                                }) {
                                    if let rowView = rowView {
                                        rowView(item, isSelected)
                                    } else {
                                        HStack {
                                            Text(item.description)
                                                .foregroundColor(isSelected ? .accentColor : .primary)
                                            Spacer()
                                            if isSelected {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.accentColor)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white)
                                    }
                                }
                                .background(Color.white)
                                if item.id != items.last?.id {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                        .offset(y: 55)
                        .zIndex(1)
                    }
                }
                , alignment: .topLeading
            )
        }
        .zIndex(2)
    }
}

// MARK: - Preview

#Preview {
    DropdownPickerPreview()
}

struct DropdownPickerPreview: View {
    @State private var selected: DropdownOption? = nil
    @State private var isExpanded = false
    
    let options = [
        DropdownOption(title: "Option 1"),
        DropdownOption(title: "Option 2"),
        DropdownOption(title: "Option 3")
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).ignoresSafeArea()
            VStack {
                // Default usage (system style)
                DropdownPicker(
                    placeholder: "Choose",
                    items: options,
                    selectedItem: $selected,
                    isExpanded: $isExpanded,
                    label: {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text(selected?.title ?? "Choose an option")
                                .fontWeight(.medium)
                            Spacer()
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                    },
                    rowView: { option, isSelected in
                        HStack {
                            Text(option.title)
                                .bold(isSelected)
                                .foregroundStyle(.black)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark").foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(isSelected ? Color.black.opacity(0.1) : Color.white)
                    }
                )
                
                if isExpanded {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isExpanded = false }
                        }
                }
            }
            Spacer()
        }
    }
}

// MARK: - Helpers

private extension Text {
    func bold(_ condition: Bool) -> Text {
        condition ? self.bold() : self
    }
}
