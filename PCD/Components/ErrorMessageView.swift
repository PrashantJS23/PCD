//
//  ErrorMessageView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import SwiftUI

struct ErrorMessageView: View {
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.system(size: 40))
            Text(message)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}
