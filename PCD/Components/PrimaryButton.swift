//
//  PrimaryButton.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var animate: Bool = true
    let action: () -> Void    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Fonts.button)
                .frame(maxWidth: .infinity, maxHeight: AppSizes.buttonHeight)
                .background(AppColors.buttonBackground)
                .foregroundColor(AppColors.buttonForeground)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.small))
                .scaleEffect(animate ? 1 : 0.95)
                .opacity(animate ? 1 : 0)
                .animation(AppAnimation.base, value: animate)
        }
    }
}
#Preview {
    PrimaryButton(title: "Submit", action: {
        
    })
}
