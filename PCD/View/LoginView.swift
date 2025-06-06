//
//  LoginView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = LoginViewModel()
    @State private var showPassword = false
    @State private var animateContent = false
    @State private var animateButton = false

    var selectedRole: String

    init(selectedRole: String) {
        self.selectedRole = selectedRole
    }

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
                    username: $viewModel.username,
                    password: $viewModel.password,
                    showPassword: $showPassword,
                    animate: animateContent
                )
                VStack(spacing: AppSpacing.medium) {
                    Toggle(Strings.rememberMe, isOn: $viewModel.rememberMe)
                        .toggleStyle(CheckboxToggleStyle())
                        .opacity(animateContent ? 1 : 0)
                        .animation(AppAnimation.delayed(0.8), value: animateContent)

                    PrimaryButton(title: Strings.loginButton, animate: animateButton) {
                        viewModel.validateAndLogin {
                            appState.isLoggedIn = true
                        }
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
        .loadingOverlay(viewModel.isLoading)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            animateContent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                animateButton = true
            }
        }
        .onDisappear {
            viewModel.showValidationError = false
        }
        .showBanner(isPresented: $viewModel.showValidationError, message: viewModel.errorMessage, type: .error)
    }
}


#Preview {
    NavigationStack {
        LoginView(selectedRole: "Vendor/External")
            .environmentObject(AppState())
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
