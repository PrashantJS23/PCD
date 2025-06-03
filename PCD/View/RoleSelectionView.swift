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
    
    let roles = [
        (title: "TNB Staff", imageName: SystemImages.personBadgeCheckmark),
        (title: "Vendor/External", imageName: SystemImages.person),
    ]
    
    var body: some View {
        GradientBackgroundView {
            VStack(spacing: AppSpacing.large) {
                LogosView()
                Spacer()
                
                VStack(spacing: AppSpacing.large) {
                    Text(Strings.selectRoleTitle)
                        .font(Fonts.label)
                        .foregroundColor(AppColors.textPrimary)
                        .opacity(animateContent ? 1 : 0)
                        .offset(y: animateContent ? 0 : 20)
                        .animation(AppAnimation.delayed(0.1), value: animateContent)
                    
                    roleGrid
                    continueButton
                }
                
                Spacer()
            }
            .safeAreaPadding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            animateContent = true
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
    
    private var continueButton: some View {
        NavigationLink(destination: LoginView(selectedRole: selectedRole ?? "")) {
            HStack {
                Text(Strings.continueButton)
                    .font(Fonts.button)
                Image(systemName: SystemImages.chevronRight)
            }
            .foregroundColor(AppColors.buttonForeground)
            .frame(maxWidth: .infinity, maxHeight: AppSizes.buttonHeight)
            .background(selectedRole != nil ? AppColors.buttonBackground : AppColors.buttonBackground.opacity(0.5))
            .opacity(selectedRole != nil ? 1 : 0.6)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            .scaleEffect(selectedRole != nil ? 1 : 0.98)
            .animation(.easeInOut(duration: 0.3), value: selectedRole)
        }
        .disabled(selectedRole == nil)
        .accessibilityLabel("Continue button")
        .accessibilityHint(selectedRole == nil ? "Disabled until role is selected" : "Proceed to login")
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        RoleSelectionView()
    }
}
