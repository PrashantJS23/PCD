//
//  DateFilterView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct DateFilterView: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var isAnimatingFilter: Bool
    var onApply: (() -> Void)?
    var onClear: (() -> Void)?
    var onClose: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(AppText.filterByDateTitle)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isAnimatingFilter = true
                        onClose?()
                    }
                } label: {
                    Image(systemName: SystemImages.xmarkCircleFill)
                        .foregroundColor(.secondary)
                        .font(.headline)
                }
            }
            
            VStack(spacing: 12) {
                DatePicker(AppText.fromText, selection: $fromDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                DatePicker(AppText.toText, selection: $toDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }
            
            HStack {
                Button(AppText.clearText) {
                    onClear?()
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button {
                    onApply?()
                } label: {
                    Text(AppText.applyText)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                            .fill(AppColors.accentYellow)
                        )
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    DateFilterView(
        fromDate: .constant(Date()),
        toDate: .constant(Date()),
        isAnimatingFilter: .constant(true)
    )
}
