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
        GradientBackgroundView(alignment: .center) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing:AppSpacing.mediumLarge) {
                    ForEach(vendorInstructions) { instruction in
                        VendorInstructionCard(instruction: instruction)
                    }
                }
                .padding(.vertical)
            }
        }
        .customNavigationBar(title: AppText.vendorRegistrationInstructionScreenTitle, isNotificationEnabled: true) { dismiss() }
    }
}

#Preview {
    RegistrationInstructionView()
}
