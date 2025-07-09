//
//  RoleCard.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct RoleCard: View {
    let title: String
    let imageName: String
    let selected: Bool
    let color1 = Color(red: 5 / 255, green: 22 / 255, blue: 58 / 255)

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .foregroundColor(selected ? .white : color1)
                .padding(.top, 16)
                .accessibilityHidden(true)
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(selected ? .white : color1)
                .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.small)
                .fill(selected ? color1 : Color.gray.opacity(0.3))
                .animation(.easeInOut(duration: 0.3), value: selected)
        )
        .scaleEffect(selected ? 1.05 : 1)
        .shadow(color: selected ? Color.black.opacity(0.3) : .clear,
                radius: selected ? 6 : 0,
                x: 0, y: 3)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selected)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(selected ? .isSelected : [])
        .accessibilityLabel(Text(title + (selected ? ", selected" : "")))
    }
}

#Preview {
    RoleCard(title: "Vendor", imageName: SystemImages.checkmarkCircleFill, selected: false)
}
