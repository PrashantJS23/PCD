//
//  DateRangePickerField.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 12/06/25.
//
import SwiftUI

struct DateRangePickerField: View {
    var title: String
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var fromDateText: String
    @Binding var toDateText: String
    var onFromTap: () -> Void
    var onToTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            HStack(spacing: AppSpacing.medium) {
                CustomTextField(
                    text: $fromDateText,
                    placeholder: AppText.fromText,
                    suffixIcon: SystemImages.calendar,
                    showUnderline: true,
                    foregroundColor: AppColors.textPrimaryLight,
                    isEditable: false,
                    onSuffixTap: onFromTap
                )
                CustomTextField(
                    text: $toDateText,
                    placeholder: AppText.toText,
                    suffixIcon: SystemImages.calendar,
                    showUnderline: true,
                    foregroundColor: AppColors.textPrimaryLight,
                    isEditable: false,
                    onSuffixTap: onToTap
                )
            }
        }
    }
}
