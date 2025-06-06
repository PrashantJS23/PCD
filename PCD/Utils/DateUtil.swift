//
//  DateUtil.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//
import SwiftUI
import Foundation

struct DateUtil {
    static func formatISO8601(_ isoDate: String,
                              dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .short,
                              locale: Locale = .current) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoDate) else {
            return "Invalid date"
        }

        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.locale = locale
        
        return formatter.string(from: date)
    }
}
