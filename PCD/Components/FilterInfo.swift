//
//  FilterInfo.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 09/06/25.
//

import SwiftUI

struct FilterInfo: View {
    var fromDate: Date
    var toDate: Date
    
    var body: some View {
        Text("\(AppText.showingResultsFromTitle) \(fromDate.formatted(date: .abbreviated, time: .omitted)) \(AppText.toText.lowercased()) \(toDate.formatted(date: .abbreviated, time: .omitted))")
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
}
