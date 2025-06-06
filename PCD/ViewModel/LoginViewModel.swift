//
//  LoginViewModel.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI
import Combine
import UIKit

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool = false
    @Published var showValidationError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func validateAndLogin(success: @escaping () -> Void) {
        let usernameTrimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTrimmed = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !usernameTrimmed.isEmpty, !passwordTrimmed.isEmpty else {
            showError(Strings.allFieldsRequiredMessage)
            return
        }

        showValidationError = false
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoading = false
            success()
        }
    }

    private func showError(_ message: String) {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        errorMessage = message
        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            showValidationError = true
        }
    }
}

