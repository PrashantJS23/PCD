//
//  MyWorkCardView.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 30/06/25.
//
import SwiftUI

struct MyWorkCardView: View {
    let index: Int
    var onButtonTap: (() -> Void)? = nil

    @State private var buttonScale: CGFloat = 1.0
    @State private var cardVisible = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header Row
            HStack {
                Text("Request #L-3553")
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text("June 20, 2025")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Description
            Text("My Work case description goes here briefly, possibly two lines.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            // Status Badge
            HStack {
                Label("Pending BU Review", systemImage: SystemImages.clock)
                    .font(.caption2)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppColors.accentYellow)
                    .foregroundColor(AppColors.textPrimaryLight)
                    .clipShape(Capsule())
                
                Spacer()
                
                // Bouncing button
                Button(action: {
                    bounceScale()
                    onButtonTap?()
                }) {
                    Image(systemName: SystemImages.chevronRight)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(LinearGradient(colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(Circle())
                        .scaleEffect(buttonScale)
                        .shadow(color: Color.accentColor.opacity(0.3), radius: 6, x: 0, y: 3)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: AppRadius.small, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
        )
        .opacity(cardVisible ? 1 : 0)
        .offset(y: cardVisible ? 0 : 20)
        .animation(.easeOut(duration: 0.5).delay(Double(index) * 0.1), value: cardVisible)
        .onAppear {
            cardVisible = true
        }
    }

    private func bounceScale() {
        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
            buttonScale = 1.15
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                buttonScale = 1.0
            }
        }
    }
}



// MARK: - Preview

struct MyWorkCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(0..<1) { i in
                MyWorkCardView(index: i) {
                    print("Tapped card \(i)")
                }
            }
           
        }
        .padding()
//        .background(Color(UIColor.systemGroupedBackground))
    }
}
