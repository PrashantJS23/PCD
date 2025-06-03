//
//  OnboardingView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var animateContent = false

    var body: some View {
        GradientBackgroundView {
            VStack(spacing: AppSpacing.medium) {
                LogosView()
                Spacer()

                Image(Images.onboardingAsset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: AppSizes.onboardingImageHeight)
                    .padding(.horizontal)
                    .opacity(animateContent ? 1 : 0)
                    .scaleEffect(animateContent ? 1 : 0.95)
                    .animation(AppAnimation.base, value: animateContent)

                Spacer()

                VStack(spacing: AppSpacing.small) {
                    Text(Strings.onboardingWelcomeTitle)
                        .font(Fonts.title)
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                    Text(Strings.onboardingWelcomeSubtitle)
                        .font(Fonts.label)
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .opacity(animateContent ? 1 : 0)
                .offset(y: animateContent ? 0 : 20)
                .animation(AppAnimation.delayed(0.3), value: animateContent)

                NavigationLink(destination: RoleSelectionView()) {
                    Text(Strings.getStartedButton)
                        .font(Fonts.button)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.buttonBackground)
                        .foregroundColor(AppColors.buttonForeground)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
                .padding(.top, AppSpacing.small)
                .opacity(animateContent ? 1 : 0)
                .animation(AppAnimation.delayed(0.6), value: animateContent)

                Text(Strings.onboardingDescription)
                    .font(Fonts.small)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, AppSpacing.small)
                    .opacity(animateContent ? 1 : 0)
                    .animation(AppAnimation.delayed(0.9), value: animateContent)
            }
            .safeAreaPadding()
        }
        .navigationBarHidden(true)
        .onAppear {
            animateContent = true
        }
    }
}


#Preview{
    NavigationStack {
        OnboardingView()
    }
}
