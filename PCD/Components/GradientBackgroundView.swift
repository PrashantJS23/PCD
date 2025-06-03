import SwiftUI

struct GradientBackgroundView<Content: View>: View {
    let content: Content
    let gradientStart: Color
    let gradientEnd: Color
    
    init(gradientStart: Color = AppColors.primaryGradientStart,
         gradientEnd: Color = AppColors.primaryGradientEnd,
         @ViewBuilder content: () -> Content) {
        self.gradientStart = gradientStart
        self.gradientEnd = gradientEnd
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [gradientStart, gradientEnd]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            content
        }
    }
}
