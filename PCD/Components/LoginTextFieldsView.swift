//
//  LoginTextFieldsView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct LoginTextFieldsView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var showPassword: Bool
    var animate: Bool

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            CustomTextField(
                text: $username,
                placeholder: Strings.usernamePlaceholder,
                prefixIcon: SystemImages.personFill
            )
            .opacity(animate ? 1 : 0)
            .animation(AppAnimation.delayed(0.4), value: animate)

            CustomTextField(
                text: $password,
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
