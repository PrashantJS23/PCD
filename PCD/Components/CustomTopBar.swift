//
//  CustomTopBar.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct CustomTopBar: View {
    @Binding var isMenuOpen: Bool
    @Binding var isNotificationOpen: Bool
    var body: some View {
        GeometryReader { geometry in
            let topInset = geometry.safeAreaInsets.top
            
            HStack {
                Button {
                    withAnimation { isMenuOpen.toggle() }
                } label: {
                    Image(systemName: SystemImages.lineHorizontalDecrease)
                        .resizable()
                        .scaledToFit()
                        .frame(width: AppSizes.menuIconWidth, height: AppSizes.menuIconHeight)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Image(AssetImages.pcdLogoWhite)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: AppSizes.logoHeight)
                    .padding(AppSpacing.extraSmall)
                
                Spacer()
                
                Button {
                    withAnimation { isNotificationOpen.toggle() }
                } label: {
                    Image(systemName: SystemImages.bellFill)
                        .resizable()
                        .scaledToFit()
                        .frame(width: AppSizes.menuIconWidth, height: AppSizes.menuIconHeight)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, topInset)
            .padding(.horizontal)
            .frame(height: topInset + AppSizes.topBarContentHeight)
            .background(LinearGradient.appGradient)
            .ignoresSafeArea(edges: .top)
        }
        .frame(height: AppSizes.topBarContentHeight)
    }
}
