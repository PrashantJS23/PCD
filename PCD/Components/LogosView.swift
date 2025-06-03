//
//  LogosView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct LogosView: View {
    // Animation state variables
    @State private var animateLogos = false
    var body: some View {
        HStack(spacing: 24) {
            Image(Images.pcdLogoGreen)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 25)
                .opacity(animateLogos ? 1 : 0)
                .offset(y: animateLogos ? 0 : -20)
                .animation(.easeOut(duration: 0.6).delay(0.2), value: animateLogos)

            Image(Images.tnbLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .opacity(animateLogos ? 1 : 0)
                .offset(y: animateLogos ? 0 : -20)
                .animation(.easeOut(duration: 0.6).delay(0.3), value: animateLogos)
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .onAppear {
            self.animateLogos = true
        }
    }
}
