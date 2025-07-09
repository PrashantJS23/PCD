//
//  GreetingCard.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct GreetingCard: View {
    var body: some View {
        Text("Hello, Prashant J. Shejwal 👋")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient.appGradient)
            .cornerRadius(AppRadius.smallMedium)
            .shadow(color: .purple.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
