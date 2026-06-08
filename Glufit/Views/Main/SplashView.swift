import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            // layout_T52Y83: padding top:324, left:104
            // Frame 2147224654: column, center, gap:22, w:194.73
            VStack(spacing: 22) {
                // GluFit! 로고 텍스트: 180.81×43.39
                Image("splash_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180.81, height: 43.39)

                // 마스코트 아이콘 행: fill × 64.91
                Image("splash_mascots")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 194.73, height: 64.91)
            }
            .frame(width: 194.73)
            // 수직 위치: top padding 324pt
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 324)
        }
    }
}

#Preview {
    SplashView()
}
