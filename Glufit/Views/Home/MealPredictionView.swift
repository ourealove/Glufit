import SwiftUI

struct MealPredictionView: View {
    @Binding var isPresented: Bool
    @State private var selectedTab = 1  // 0=매장 메뉴, 1=음식·레시피

    private let recentKeywords = ["샐러드", "냉면", "김밥", "비빔밥", "떡볶이"]

    private struct PopularItem {
        let rank: Int; let name: String; let amount: String
        let calories: String; let bloodSugar: String
    }
    private let popularItems: [PopularItem] = [
        PopularItem(rank: 1, name: "삶은 계란",   amount: "1개 (50g)",    calories: "65",  bloodSugar: "+4"),
        PopularItem(rank: 2, name: "토마토 샐러드", amount: "1인분 (150g)", calories: "120", bloodSugar: "+5"),
        PopularItem(rank: 3, name: "그릭 요거트",  amount: "1컵 (245g)",   calories: "100", bloodSugar: "+3"),
        PopularItem(rank: 4, name: "닭 가슴살",   amount: "100g",         calories: "165", bloodSugar: "+2"),
        PopularItem(rank: 5, name: "브로콜리",    amount: "1컵 (156g)",   calories: "55",  bloodSugar: "+1"),
        PopularItem(rank: 6, name: "아몬드",      amount: "28g (한 줌)",   calories: "160", bloodSugar: "+2"),
        PopularItem(rank: 7, name: "연어 구이",   amount: "100g",         calories: "206", bloodSugar: "+3"),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Navigation bar
                navigationBar

                // Tab bar
                tabBar

                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        recentSearchSection
                        popularSearchSection
                        // bottom padding for the sticky button
                        Color.clear.frame(height: 90)
                    }
                }
            }

            // Sticky bottom button
            bottomButton
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: - Navigation bar

    private var navigationBar: some View {
        HStack(spacing: 4) {
            Button { isPresented = false } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gr900)
                    .frame(width: 28, height: 28)
            }

            // Search field
            HStack(spacing: 10) {
                Text("먹을 음식을 검색해보세요")
                    .font(.bodyM16)
                    .tracking(-0.16)
                    .foregroundColor(.gr500)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            .frame(height: 44)
            .background(Color(hex: "EDF0F4"))
            .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 52)
    }

    // MARK: - Tab bar

    private var tabBar: some View {
        GeometryReader { geo in
            let tabWidth = (geo.size.width - 32) / 2
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    tabButton(title: "음식,레시피", index: 1)
                    tabButton(title: "매장 메뉴", index: 0)
                }
                .frame(height: 32)
                .padding(.horizontal, 16)

                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gr200)
                        .frame(height: 2)
                    Rectangle()
                        .fill(Color.g400)
                        .frame(width: tabWidth, height: 2)
                        .offset(x: selectedTab == 1 ? 0 : tabWidth)
                        .animation(.easeInOut(duration: 0.2), value: selectedTab)
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(height: 34)
        .padding(.top, 12)
    }

    private func tabButton(title: String, index: Int) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) { selectedTab = index }
        } label: {
            Text(title)
                .font(.bodySB16)
                .tracking(-0.16)
                .foregroundColor(.gr900)
                .frame(maxWidth: .infinity)
                .frame(height: 32)
        }
    }

    // MARK: - Recent search section

    private var recentSearchSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("최근 검색어")
                .font(.bodySB18)
                .tracking(-0.18)
                .foregroundColor(.gr900)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(recentKeywords, id: \.self) { keyword in
                        recentChip(keyword)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func recentChip(_ keyword: String) -> some View {
        HStack(spacing: 4) {
            Text(keyword)
                .font(.bodyM14)
                .tracking(-0.14)
                .foregroundColor(.gr700)
            Image(systemName: "xmark")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.gr400)
                .frame(width: 14, height: 14)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .frame(height: 34)
        .background(Color.white)
        .overlay(
            Capsule().stroke(Color.gr300, lineWidth: 1)
        )
        .clipShape(Capsule())
    }

    // MARK: - Popular search section

    private var popularSearchSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("인기 검색어")
                .font(.bodySB18)
                .tracking(-0.18)
                .foregroundColor(.gr900)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)

            ForEach(popularItems, id: \.rank) { item in
                popularItemRow(item)
            }
        }
        .padding(.vertical, 12)
    }

    private func popularItemRow(_ item: PopularItem) -> some View {
        HStack(spacing: 4) {
            // Row content
            HStack(spacing: 0) {
                // Rank number
                Text("\(item.rank)")
                    .font(.bodyM16)
                    .tracking(-0.16)
                    .foregroundColor(.gr900)
                    .frame(width: 16)

                Spacer().frame(width: 17)

                // Food info
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.bodyM16)
                        .tracking(-0.16)
                        .foregroundColor(.gr900)
                        .frame(width: 132, alignment: .leading)
                    Text(item.amount)
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr400)
                        .frame(width: 132, alignment: .leading)
                }
                .frame(width: 132, alignment: .leading)

                Spacer().frame(width: 36)

                // Nutrition info
                HStack(spacing: 2) {
                    HStack(spacing: 0) {
                        Text(item.calories)
                            .font(.bodyM14)
                            .tracking(-0.14)
                            .foregroundColor(.gr700)
                        Text("kcal")
                            .font(.bodyM14)
                            .tracking(-0.14)
                            .foregroundColor(.gr700)
                    }
                    Text("/")
                        .font(.bodyM14)
                        .foregroundColor(.gr700)
                    HStack(spacing: 0) {
                        Text(item.bloodSugar)
                            .font(.bodyM14)
                            .tracking(-0.14)
                            .foregroundColor(.gr700)
                        Text("mg/dL")
                            .font(.bodyM14)
                            .tracking(-0.14)
                            .foregroundColor(.gr700)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 0)
            .frame(maxWidth: .infinity, alignment: .leading)

            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gr400)
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 16)
        .overlay(
            Rectangle()
                .fill(Color.gr200)
                .frame(height: 1),
            alignment: .bottom
        )
    }

    // MARK: - Bottom button

    private var bottomButton: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 0)
                .shadow(color: Color(red: 163/255, green: 163/255, blue: 163/255).opacity(0.21), radius: 4, x: 0, y: -2)

            Button {} label: {
                Text("자세히 보기")
                    .font(.bodySB18)
                    .tracking(-0.18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.g400)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 17)
            .padding(.top, 12)
            .padding(.bottom, 32)
            .background(Color.white)
        }
    }
}

#Preview {
    MealPredictionView(isPresented: .constant(true))
}
