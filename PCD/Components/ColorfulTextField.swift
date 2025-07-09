//
//  ColorfulTextField.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//

import SwiftUI

struct ColorfulTextField: View {
    @Binding var text: String
    var placeholder: String
    var iconName: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(.vertical, 10)
                .padding(.leading, 12)

            Image(systemName: iconName)
                .foregroundColor(.blue)
                .padding(.trailing, 12)
        }
        .background(Color.white)
        .cornerRadius(AppRadius.smallMedium)
        .shadow(color: Color.black.opacity(0.01), radius: 5, x: 0, y: 3)
    }
}
