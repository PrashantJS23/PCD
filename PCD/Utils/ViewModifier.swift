//
//  ViewModifier.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 18/06/25.
//

import SwiftUI

struct InputStyle: ViewModifier {
    var backgroundColor: Color = AppColors.inputBackground
    var foregroundColor: Color = .black

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, AppSizes.padding)
            .frame(height: AppSizes.inputHeight)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(AppRadius.small)
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.small)
                    .stroke(AppColors.inputBorder, lineWidth: 1)
            )
    }
}

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: AppSizes.inputHeight)
            .frame(minWidth: AppSizes.buttonMinWidth)
            .padding(.horizontal)
            .background(LinearGradient.appGradient.cornerRadius(AppRadius.small))
            .foregroundColor(.white)
            .shadow(color: AppColors.buttonShadow, radius: 8, x: 0, y: 4)
    }
}

struct ScaledOnTap: ViewModifier {
    var scaleAmount: CGFloat = 0.95

    @GestureState private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scaleAmount : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.4), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($isPressed) { _, state, _ in
                        state = true
                    }
            )
    }
}
