//
//  RoleSelectionView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct RoleSelectionView: View {
    @State private var selectedRole: String? = nil
    @State private var animateContent = false
    @State private var navigateToLogin = false
    let roles = [
        (title: "TNB Staff", imageName: SystemImages.personBadgeCheckmark),
        (title: "Vendor/External", imageName: SystemImages.person),
    ]
    
    var body: some View {
        GradientBackgroundView {
            VStack(spacing: AppSpacing.huge) {
                LogosView()
                Spacer(minLength: 0)
                
                VStack(spacing: AppSpacing.huge) {
                    Text(AppText.selectRoleTitle)
                        .font(Fonts.label)
                        .foregroundColor(AppColors.textPrimaryDark)
                        .opacity(animateContent ? 1 : 0)
                        .offset(y: animateContent ? 0 : 20)
                        .animation(AppAnimation.delayed(0.1), value: animateContent)
                    
                    roleGrid
                    PrimaryButton(title: AppText.continueButton) {
                        navigateToLogin = true
                    }
                    .disabled(selectedRole == nil)
                    .opacity(selectedRole != nil ? 1.0 : 0.6)
                    .padding(.horizontal)
                }
                .offset(y: -40)
                
                Spacer(minLength: 0)
            }
            .safeAreaPadding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            animateContent = true
        }
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView(selectedRole: selectedRole ?? "")
        }
    }
    
    private var roleGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: AppSpacing.medium),
                GridItem(.flexible(), spacing: AppSpacing.medium),
            ],
            spacing: AppSpacing.medium
        ) {
            ForEach(roles, id: \.title) { role in
                RoleCard(
                    title: role.title,
                    imageName: role.imageName,
                    selected: selectedRole == role.title
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        selectedRole = role.title
                    }
                }
            }
        }
        .padding(.horizontal)
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 20)
        .animation(AppAnimation.delayed(0.2), value: animateContent)
    }
}

#Preview {
    NavigationStack {
        RoleSelectionView()
    }
}
