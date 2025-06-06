//
//  CustomTextField.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI


// Custom Text Field Component
struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecureTextEntry: Bool = false
    var prefixIcon: String? = nil
    var suffixIcon: String? = nil
    var onSuffixTap: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 10) {
            // Prefix Icon
            if let prefixIcon = prefixIcon {
                Image(systemName: prefixIcon)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            }

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }

                if isSecureTextEntry {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .tint(.gray)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .tint(.gray)
                }
            }

            // Suffix Icon
            if let suffixIcon = suffixIcon {
                Button(action: {
                    onSuffixTap?()
                }) {
                    Image(systemName: suffixIcon)
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
        }
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var username = ""

    static var previews: some View {
        CustomTextField(
            text: $username,
            placeholder: "Username",
            prefixIcon: "person.fill"
        )
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
