//
//  CustomTextField.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecureTextEntry: Bool
    var prefixIcon: String?
    var suffixIcon: String?
    var showUnderline: Bool
    var foregroundColor: Color
    var backgroundColor: Color
    var underlineColor: Color
    var isEditable: Bool
    var onSuffixTap: (() -> Void)?

    init(
        text: Binding<String>,
        placeholder: String,
        isSecureTextEntry: Bool = false,
        prefixIcon: String? = nil,
        suffixIcon: String? = nil,
        showUnderline: Bool = false,
        foregroundColor: Color = .white,
        backgroundColor: Color = .white.opacity(0.1),
        underlineColor: Color = .gray.opacity(0.5),
        isEditable: Bool = true,
        onSuffixTap: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.prefixIcon = prefixIcon
        self.suffixIcon = suffixIcon
        self.showUnderline = showUnderline
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.underlineColor = underlineColor
        self.isEditable = isEditable
        self.onSuffixTap = onSuffixTap
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                if let prefixIcon = prefixIcon {
                    Image(systemName: prefixIcon)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                } else {
                    Spacer()
                        .frame(width: 0)
                }

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                            .transition(.opacity)
                    }

                    if isSecureTextEntry {
                        SecureField("", text: $text)
                            .font(.system(size: 16))
                            .foregroundColor(foregroundColor)
                            .tint(.gray)
                            .disabled(!isEditable)
                    } else {
                        TextField("", text: $text)
                            .font(.system(size: 16))
                            .foregroundColor(foregroundColor)
                            .tint(.gray)
                            .disabled(!isEditable)
                    }
                }

                if let suffixIcon = suffixIcon {
                    Button(action: { onSuffixTap?() }) {
                        Image(systemName: suffixIcon)
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, (prefixIcon != nil) ? 8 : 0)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.small))

            if showUnderline {
                Rectangle()
                    .fill(underlineColor)
                    .frame(height: 1)
                    .padding(.horizontal, 4)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: text)
    }
}

// MARK: - Preview

struct CustomTextField_Previews: PreviewProvider {
    @State static var username = ""

    static var previews: some View {
        VStack(spacing: 20) {
            CustomTextField(
                text: $username,
                placeholder: "Username",
                prefixIcon: "person.fill",
                suffixIcon: "eye.fill",
                showUnderline: false,
                foregroundColor: .black,
                backgroundColor: .white,
                underlineColor: .blue
            )

            CustomTextField(
                text: $username,
                placeholder: "Email",
                showUnderline: true
            )
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .previewLayout(.sizeThatFits)
    }
}

