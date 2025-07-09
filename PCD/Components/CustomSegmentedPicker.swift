//
//  CustomSegmentedPicker.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 25/06/25.
//
import SwiftUI

struct CustomSegmentedPicker: View {
    @Binding var selectedIndex: Int
    let options: [String]
    
    var selectedColor: Color = .blue
    var selectedTextColor: Color = .white
    var unselectedTextColor: Color = .primary
    var backgroundColor: Color = Color.gray.opacity(0.2)
    var minSegmentWidth: CGFloat = 40
    var verticalPadding: CGFloat = 8
    var horizontalPadding: CGFloat = 16
    
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(options.indices, id: \.self) { index in
                let isSelected = selectedIndex == index
                
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedIndex = index
                    }
                } label: {
                    Text(options[index])
                        .fontWeight(.medium)
                        .foregroundColor(isSelected ? selectedTextColor : unselectedTextColor)
                        .padding(.vertical, verticalPadding)
                        .padding(.horizontal, horizontalPadding)
                        .frame(minWidth: minSegmentWidth)
                        .background(
                            ZStack {
                                if isSelected {
                                    Capsule()
                                        .fill(selectedColor)
                                        .matchedGeometryEffect(id: "selectionBubble", in: animationNamespace)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
                .fixedSize()
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
        .fixedSize(horizontal: true, vertical: false)
    }
}


#Preview {
    CustomSegmentedPickerPreview()
}

struct CustomSegmentedPickerPreview: View {
    @State private var selected = 0
    let filters = ["All", "Favorites", "Archived"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Filter")
                .font(.title2)
                .bold()
            
            CustomSegmentedPicker(
                selectedIndex: $selected,
                options: filters,
                selectedColor: .blue,
                selectedTextColor: .white,
                unselectedTextColor: .blue.opacity(0.7),
                backgroundColor: Color.blue.opacity(0.15),
                minSegmentWidth: 80
            )
            .padding(.horizontal)
            
            Text("Selected: \(filters[selected])")
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(16)
        .padding()
    }
}
