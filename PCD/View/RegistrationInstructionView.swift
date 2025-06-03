//
//  RegistrationInstructionView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

struct RegistrationInstructionView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        GradientBackgroundView {
            Text("Instruction coming soon...")
                .foregroundColor(.white)
        }
        .customNavigationBar(title: "Vendor Registration Instruction") { dismiss() }
    }
}

#Preview {
    RegistrationInstructionView()
}
