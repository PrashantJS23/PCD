//
//  VendorInstructionCard.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//

import SwiftUI

struct VendorInstructionCard: View {
    @Environment(\.openURL) var openURL
    @State private var isVisible = false
    let instruction: VendorInstruction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(instruction.title)
                .font(Fonts.label)
                .foregroundColor(AppColors.textPrimary)
                .animation(.easeInOut, value: isVisible)
            
            if let urlString = instruction.urlString, let url = URL(string: urlString) {
                Button(action: {
                    openURL(url)
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: SystemImages.link)
                        Text(Strings.viewInstructionButtonTitle)
                    }
                    .font(.subheadline)
                    .foregroundColor(AppColors.accentYellow)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: AppColors.shadowColor, radius: 8, x: 0, y: 4)
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
        .animation(.easeOut(duration: 0.5), value: isVisible)
        .padding(.horizontal)
        .onAppear {
            isVisible = true
        }
    }
}

#Preview {
    VendorInstructionCard(instruction: .init(
        title: "Enter your Vendor or External User ID exactly as provided. This ID is unique to your account and is required for all external transactions.",
        urlString: "https://www.google.com"
    ))
}
