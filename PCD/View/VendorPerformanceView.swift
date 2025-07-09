//
//  VendorPerformanceView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 11/06/25.
//

import SwiftUI

struct VendorPerformanceView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Coming Soon...")
            .customNavigationBar(title: "Vendor Performance", isGradientBackground: true) {
                dismiss()
            }
    }
}

#Preview {
    VendorPerformanceView()
}
