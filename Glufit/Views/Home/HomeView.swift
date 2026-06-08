import SwiftUI

// Figma: home frame (402×874pt, white bg)
// Layout (absolute y positions from Figma):
//   Status bar: 0–62
//   Header: y:66, 369.75×28
//   Top card: y:120, 370×100
//   Calendar: y:248
//   Food carousel: y:341
//   Dots: y:721
//   Bottom bar: y:784 (in MainTabView)
struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // 상단 Safe Area 확보 (status bar)
                Color.clear.frame(height: 4)

                // 헤더: GluFit! 로고 + 벨 아이콘 (y:66 기준)
                header
                    .padding(.horizontal, 16)
                    .padding(.top, 4)

                // 상단 카드 캐러셀 (y:120 → 헤더 아래 26pt 간격)
                HomeTopCardCarousel()
                    .padding(.horizontal, 16)
                    .padding(.top, 26)

                // 주 캘린더 (y:248 → 카드 아래 28pt)
                WeeklyCalendar()
                    .padding(.leading, 23)
                    .padding(.top, 28)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // 식단 캐러셀 (y:341 → 캘린더 아래 ~41pt, 풀 너비)
                FoodCarousel()
                    .padding(.top, 41)

                Spacer()
            }
        }
    }

    // MARK: - 헤더 (x:16, y:66, 369.75×28 — row, space-between)
    // Frame 2147224647: GluFit! 로고(100×24) + 벨 아이콘(28×28)
    private var header: some View {
        HStack {
            // GluFit! 로고 (SVG, 100×24)
            Image("logo_glufit")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 24)

            Spacer()

            // 벨 아이콘 (28×28) — icon_home_bell Property 1=Default
            Image("icon_home_bell")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .frame(height: 28)
    }


}

#Preview {
    HomeView()
}
