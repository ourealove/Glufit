import SwiftUI
import Combine

struct CardPage {
    let label: String
    let score: Int
    let badgeValue: String
    let badgeUnit: String
    let mascot: String
}

// Carousel wrapper: 5초 자동 전환 + 좌우 스와이프
// Dots: Figma y:86, x:176 (first), gap 5pt (dot 6pt, space 187-182=5)
struct HomeTopCardCarousel: View {
    @State private var currentPage = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    private let pages: [CardPage] = [
        CardPage(label: "오늘 혈당 점수", score: 45, badgeValue: "168", badgeUnit: "mg/dL", mascot: "img_home_top_card_danger"),
        CardPage(label: "오늘 칼로리 점수", score: 20, badgeValue: "2,430", badgeUnit: "kcal", mascot: "img_home_top_card_danger"),
    ]

    var body: some View {
        ZStack(alignment: .topLeading) {
            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { i in
                    HomeTopCard(page: pages[i])
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)

            HStack(spacing: 5) {
                ForEach(pages.indices, id: \.self) { i in
                    Circle()
                        .fill(i == currentPage ? Color.white : Color.gr500)
                        .frame(width: 6, height: 6)
                }
            }
            .padding(.leading, 176)
            .padding(.top, 86)
        }
        .frame(height: 100)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                currentPage = (currentPage + 1) % pages.count
            }
        }
    }
}

// Figma: home_top card (370×100pt)
// gradient_01: 90deg, #00A57C → #5DD7B9, borderRadius 10px
// Left section (Component 3): x:20, y:15, 148×70
//   Label: x:0, y:0, caption_sb_12, white
//   Score row: x:0, y:18, 68×52, row gap:4
//     score display_sb_40 (w:51) + "점" body_sb_14 (13×38)
//   Badge (Component 2): x:76, y:41, 72×24, Green600 bg, radius 20
//     value + unit caption_m_12, Grey/100
// Mascot: x:252, y:0, 100×100
struct HomeTopCard: View {
    let page: CardPage

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [.gradientStart, .gradientEnd],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            leftSection
                .padding(.leading, 20)
                .padding(.top, 15)

            Image(page.mascot)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.leading, 252)
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var leftSection: some View {
        ZStack(alignment: .topLeading) {
            Text(page.label)
                .font(.captionSB12)
                .tracking(-0.12)
                .foregroundColor(.white)
                .frame(height: 16, alignment: .leading)
                .lineLimit(1)

            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(page.score)")
                    .font(.displaySB40)
                    .tracking(-0.4)
                    .foregroundColor(.white)
                    .frame(width: 51, alignment: .leading)
                Text("점")
                    .font(.bodySB14)
                    .tracking(-0.14)
                    .foregroundColor(.white)
                    .frame(width: 13, height: 38)
            }
            .frame(width: 68, height: 52)
            .padding(.top, 18)

            HStack(spacing: 2) {
                Text(page.badgeValue)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr100)
                Text(page.badgeUnit)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr100)
            }
            .frame(width: 72, height: 24)
            .background(Color.g600)
            .clipShape(Capsule())
            .padding(.leading, 76)
            .padding(.top, 41)
        }
        .frame(width: 148, height: 70)
    }
}

#Preview {
    HomeTopCardCarousel()
        .padding(.horizontal, 16)
}
