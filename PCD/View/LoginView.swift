//
//  LoginView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    var selectedRole: String

    @State private var showPassword = false
    @State private var rememberMe = false
    @State private var animateContent = false
    @State private var animateButton = false

    var body: some View {
        GradientBackgroundView {
            VStack(spacing: AppSpacing.medium) {
                LogosView()
                Spacer()

                LoginHeaderView(
                    title: Strings.loginTitle,
                    subtitle: Strings.loginSubtitle + selectedRole,
                    animate: animateContent
                )

                LoginTextFieldsView(
                    showPassword: $showPassword,
                    animate: animateContent
                )

                VStack(spacing: AppSpacing.medium) {
                    Toggle(Strings.rememberMe, isOn: $rememberMe)
                        .toggleStyle(CheckboxToggleStyle())
                        .opacity(animateContent ? 1 : 0)
                        .animation(AppAnimation.delayed(0.8), value: animateContent)

                    Button(action: {}) {
                        Text(Strings.loginButton)
                            .font(Fonts.button)
                            .frame(maxWidth: .infinity, maxHeight: AppSizes.buttonHeight)
                            .background(AppColors.buttonBackground)
                            .foregroundColor(AppColors.buttonForeground)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .scaleEffect(animateButton ? 1 : 0.95)
                            .opacity(animateButton ? 1 : 0)
                            .animation(AppAnimation.base, value: animateButton)
                    }

                    Button(action: { dismiss() }) {
                        Text(Strings.notYourRoleButton)
                            .font(Fonts.label)
                            .foregroundColor(.white)
                    }
                    .opacity(animateContent ? 1 : 0)
                    .animation(AppAnimation.delayed(1.0), value: animateContent)
                }

                Spacer()

                LoginFooterLinksView(animate: animateContent)
            }
            .padding(.horizontal)
            .safeAreaPadding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            animateContent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                animateButton = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(selectedRole: "Vendor/External")
    }
}

struct LoginHeaderView: View {
    var title: String
    var subtitle: String
    var animate: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(title)
                .font(Fonts.title)
                .foregroundColor(AppColors.textPrimary)
                .opacity(animate ? 1 : 0)
                .animation(AppAnimation.base, value: animate)

            Text(subtitle)
                .font(Fonts.label)
                .foregroundColor(AppColors.textSecondary)
                .opacity(animate ? 1 : 0)
                .animation(AppAnimation.delayed(0.2), value: animate)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct LoginTextFieldsView: View {
    @Binding var showPassword: Bool
    var animate: Bool

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            CustomTextField(
                placeholder: Strings.usernamePlaceholder,
                prefixIcon: SystemImages.personFill
            )
            .opacity(animate ? 1 : 0)
            .animation(AppAnimation.delayed(0.4), value: animate)

            CustomTextField(
                placeholder: Strings.passwordPlaceholder,
                isSecureTextEntry: !showPassword,
                prefixIcon: SystemImages.lockFill,
                suffixIcon: showPassword ? SystemImages.eyeFill : SystemImages.eyeSlashFill,
                onSuffixTap: { showPassword.toggle() }
            )
            .opacity(animate ? 1 : 0)
            .animation(AppAnimation.delayed(0.6), value: animate)
        }
    }
}

struct LoginFooterLinksView: View {
    var animate: Bool

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            NavigationLink(destination: AnnouncementView()) {
                HStack(spacing: AppSpacing.tiny) {
                    Image(systemName: SystemImages.bellBadgeFill)
                        .foregroundColor(.white)
                    Text(Strings.viewAnnouncementTitle)
                        .font(Fonts.label)
                        .foregroundColor(.white)
                        .underline()
                }
            }

            NavigationLink(destination: RegistrationInstructionView()) {
                HStack(spacing: AppSpacing.tiny) {
                    Image(systemName: SystemImages.personCropCircleBadgeCheckmark)
                        .foregroundColor(.white)
                    Text(Strings.viewVendorRegistrationTitle)
                        .font(Fonts.label)
                        .foregroundColor(.white)
                        .underline()
                }
            }
        }
        .opacity(animate ? 1 : 0)
        .animation(AppAnimation.delayed(1.0), value: animate)
    }
}
