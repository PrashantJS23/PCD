//
//  ErrorBannerModifier.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String
    var duration: TimeInterval = 3.0
    var type: BannerType
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            if isPresented {
                BannerView(message: message, type: type, onClose: {
                    withAnimation {
                        isPresented = false
                    }
                })
                .transition(.move(edge: .top).combined(with: .opacity))
                .padding(.top, 8)
                .zIndex(1)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func showBanner(isPresented: Binding<Bool>, message: String, type: BannerType = .success, duration: TimeInterval = 3.0) -> some View {
        self.modifier(BannerModifier(isPresented: isPresented, message: message, duration: duration, type: type))
    }
}
