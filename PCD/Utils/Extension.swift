//
//  Extension.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 04/06/25.
//
import SwiftUI

// MARK: - LinearGradient Extension
extension LinearGradient {
    static let appGradient = LinearGradient(
        colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension AppState {
    static var preview: AppState {
        let state = AppState()
        return state
    }
}


extension View {
    func errorOverlay(_ message: String?) -> some View {
        ZStack {
            self
            if let message = message {
                ErrorMessageView(message: message)
                    .padding()
            }
        }
    }
    
    func inputStyle(background: Color = AppColors.inputBackground, foreground: Color = .black) -> some View {
        self.modifier(InputStyle(backgroundColor: background, foregroundColor: foreground))
    }

    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
    
    func scaleOnTap(_ scaleAmount: CGFloat = 0.95) -> some View {
        self.modifier(ScaledOnTap(scaleAmount: scaleAmount))
    }
    
    func hideTabBarOnScroll(isScrolling: Binding<Bool>) -> some View {
        self.modifier(ScrollHideModifier(isScrolling: isScrolling))
    }
    
    func customNavigationBar(title: String, isGradientBackground: Bool = false, isNotificationEnabled: Bool = false, backAction: @escaping () -> Void) -> some View {
        self.modifier(CustomNavigationBar(title: title, isGradientBackground: isGradientBackground, isNotificationEnabled: isNotificationEnabled, backAction: backAction))
    }
    
    func showBanner(isPresented: Binding<Bool>, message: String, type: BannerType = .success, duration: TimeInterval = 3.0) -> some View {
        self.modifier(BannerModifier(isPresented: isPresented, message: message, duration: duration, type: type))
    }
}

