//
//  ColorfulCardView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//
import SwiftUI

struct HomeCardView: View {
    let card: HomeMetrics
    var onNumberTap: ((DashboardMetric) -> Void)? = nil

    @State private var tappedMetricID: UUID?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(card.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)

            ForEach(card.metrics) { metric in
                HStack {
                    Text(metric.subtitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white.opacity(0.85))
                    Spacer()
                    Button(action: {
                        tappedMetricID = metric.id
                        onNumberTap?(metric)

                        // Reset animation after a short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            tappedMetricID = nil
                        }
                    }) {
                        Text(metric.value)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .frame(minWidth: 40, maxHeight: 30)
                            .scaleEffect(tappedMetricID == metric.id ? 1.1 : 1.0)
                            .animation(.easeOut(duration: 0.2), value: tappedMetricID)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [card.cardColor.color.opacity(0.85), card.cardColor.color],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .shadow(color: card.cardColor.color.opacity(0.4), radius: 10, x: 0, y: 6)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}


#Preview {
    HomeCardView(card:  HomeMetrics(
        title: "Pending Vendor",
        metrics: [
            DashboardMetric(subtitle: "Non STO", value: "\(Int.random(in: 100..<200))"),
            DashboardMetric(subtitle: "Freight", value: "\(Int.random(in: 20..<50))")
        ],
        cardColor: CardColor.charcoal
    ))
}
