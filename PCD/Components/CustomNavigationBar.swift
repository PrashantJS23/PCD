//
//  CustomNavigationBarModifier.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct CustomNavigationBar: ViewModifier {
    let title: String
    let backAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: backAction) {
                        Image(systemName: SystemImages.chevronLeft)
                            .font(Fonts.backButton)
                            .foregroundColor(.white)
                    }
                }
            }
    }
}

extension View {
    func customNavigationBar(title: String, backAction: @escaping () -> Void) -> some View {
        self.modifier(CustomNavigationBar(title: title, backAction: backAction))
    }
}
