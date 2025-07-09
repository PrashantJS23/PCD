import SwiftUI
import UIKit

struct CustomNavigationBar: ViewModifier {
    let title: String
    var isGradientBackground: Bool = false
    var isNotificationEnabled: Bool = false
    let backAction: () -> Void
    @State private var showNotifications = false
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                content
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: backAction) {
                                Image(systemName: SystemImages.chevronLeft)
                                    .font(Fonts.backButton)
                                    .foregroundColor(.white)
                            }
                        }
                        if !isNotificationEnabled {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button{
                                  showNotifications = true
                                } label :{
                                    Image(systemName: SystemImages.bellFill)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: AppSizes.menuIconWidth, height: AppSizes.menuIconHeight)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .navigationDestination(isPresented: $showNotifications) {
                        NotificationView()
                    }
                    .toolbarBackground(
                        isGradientBackground
                        ? AppColors.primaryGradientEnd
                        :AppColors.navBarBackground,
                        for: .navigationBar
                    )
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            }
        }
    }
}
