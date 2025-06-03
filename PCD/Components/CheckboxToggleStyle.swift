//
//  CheckboxToggleStyle.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/05/25.
//
import SwiftUI

// Custom Checkbox Toggle Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? SystemImages.checkmarkCircleFill : SystemImages.circle)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .yellow : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
                .font(.system(size: 16))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
