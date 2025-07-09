//
//  RadioButton.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 11/06/25.
//
import SwiftUI

struct RadioButton<T: Hashable>: View {
    let label: String
    let value: T
    @Binding var selected: T
    var isVisible: Bool = true
    
    var isSelected: Bool { selected == value }
    
    var body: some View {
        if isVisible {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .strokeBorder(Color.gray.opacity(0.6), lineWidth: 2)
                        .frame(width: 24, height: 24)
                
                        Circle()
                            .fill(isSelected ? AppColors.primaryGradientEnd : Color.gray.opacity(0.6))
                            .frame(width: 12, height: 12)
                            .transition(.scale)
                    
                }
                .animation(.easeInOut(duration: 0.2), value: isSelected)
                
                Text(label)
                    .font(Fonts.button)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColors.textPrimaryLight)
                
                Spacer()
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
            .onTapGesture {
                selected = value
            }
        }
    }
}

#Preview {
    RadioButton(label: "Non STO", value: "Option 1", selected: .constant("Option 1"), isVisible: true)
}
