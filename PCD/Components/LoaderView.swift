//
//  LoaderView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct LoaderView: View {
    @State private var rotation = Angle.degrees(0)
    @State private var pulse = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            // Rotating coil ring
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.white, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(rotation)
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                        rotation = Angle.degrees(360)
                    }
                }
            
            // Bolt icon in center with subtle pulsing
            Image(systemName: "bolt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
                .scaleEffect(pulse ? 1.3 : 0.9)
                .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulse)
                .onAppear {
                    pulse = true
                }
        }
    }
}

#Preview {
    LoaderView()
}
