import SwiftUI

struct GradientBackgroundView<Content: View>: View {
    let alignment: Alignment
    let content: Content
    let gradientStart: Color
    let gradientEnd: Color
    init(gradientStart: Color = AppColors.primaryGradientStart,
         gradientEnd: Color = AppColors.primaryGradientEnd,
         alignment: Alignment = .top,
         @ViewBuilder content: () -> Content) {
        self.gradientStart = gradientStart
        self.gradientEnd = gradientEnd
        self.alignment = alignment
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
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
