import SwiftUI

struct GluLogView: View {
    @State private var selectedTab: GraphTab = .all

    enum GraphTab: String, CaseIterable {
        case all     = "전체"
        case weight  = "몸무게"
        case calorie = "칼로리"
        case blood   = "혈당"

        var graphImageName: String {
            switch self {
            case .all:     return "glulog_graph_all"
            case .weight:  return "glulog_graph_weight"
            case .calorie: return "glulog_graph_kcal"
            case .blood:   return "glulog_graph_mgdl"
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "EDF0F4").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header

                    // AI feedback: padding 12 16
                    aiFeedbackCard
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)

                    // gap: 12pt (y:213.83 → y:225.83)
                    Color.clear.frame(height: 12)

                    // 그래프 + 통계 섹션 (column gap:4)
                    VStack(spacing: 4) {
                        // 그래프 탭 (padding 0 16, column gap:12)
                        VStack(spacing: 12) {
                            segmentTabs
                            graphCard
                        }
                        .padding(.horizontal, 16)

                        // 통계 행 (padding 12 16)
                        statsRow
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }

                    // gap: 24pt (y:585.83 → y:609.83)
                    Color.clear.frame(height: 24)

                    // 하루 추천 섭취량 제목 (x:17, bodySB18, Grey/900)
                    Text("하루 추천 섭취량")
                        .font(.bodySB18)
                        .tracking(-0.18)
                        .foregroundColor(.gr900)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 17)
                        .padding(.trailing, 16)

                    // gap: 8pt (y:636.83 → y:644.83)
                    Color.clear.frame(height: 8)

                    // 영양소 카드 (padding 0 16)
                    nutrientCard
                        .padding(.horizontal, 16)

                    Spacer(minLength: 90)
                }
            }
        }
    }

    // MARK: - 헤더
    // layout_C17BAX: row, center, gap:242, padding 8 16, h:44
    private var header: some View {
        HStack {
            Text("Glulog")
                .font(.montserratEB30)
                .tracking(-0.3)
                .foregroundColor(.g400)
            Spacer()
            Image("icon_share")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 44)
    }

    // MARK: - AI 피드백 카드
    // layout_S3XWUI: row, center, gap:12, padding 12 20
    private var aiFeedbackCard: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("img_carousel_score_warning")
                .resizable()
                .scaledToFit()
                .frame(width: 59.83, height: 59.83)

            Text("고칼로리 식사가 자주 기록되었어요. \n다음 주는 안정 구간을 함께 늘려봐요!")
                .font(.bodyM14)
                .tracking(-0.14)
                .foregroundColor(.g700)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
    }

    // MARK: - 세그먼트 탭
    // layout_L66ZLI: row, space-between, fill / each pill: h:40, radius:20
    private var segmentTabs: some View {
        HStack(spacing: 0) {
            ForEach(GraphTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    Text(tab.rawValue)
                        .font(selectedTab == tab ? .bodySB14 : .bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(selectedTab == tab ? .white : .gr500)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedTab == tab ? Color.g400 : Color.clear)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
    }

    // MARK: - 그래프 카드
    // layout_ZMHF64: shadow 그림자 (rgba(115,115,115,0.25) r:4 y:3), borderRadius:10
    private var graphCard: some View {
        Image(selectedTab.graphImageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color(hex: "737373").opacity(0.25), radius: 4, x: 0, y: 3)
            .transition(.opacity)
            .id(selectedTab)
    }

    // MARK: - 통계 행
    // layout_6VPU6G: row, center, gap:8
    // 각 카드: 118×70, column, gap:2, padding 12 20, radius:10, white
    // 제목: captionM12, Grey/800
    // 값: titleSB20, Grey/800
    // 단위: captionM12, Grey/700
    private var statsRow: some View {
        HStack(spacing: 8) {
            statCard(title: "평균 혈당",   value: "150",  unit: "mg/dL", unitWidth: 35)
            statCard(title: "평균 몸무게", value: "62.5", unit: "kg",    unitWidth: 14)
            statCard(title: "평균 칼로리", value: "845",  unit: "kcal",  unitWidth: 22)
        }
        .frame(maxWidth: .infinity)
    }

    private func statCard(title: String, value: String, unit: String, unitWidth: CGFloat) -> some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr800)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            HStack(spacing: 4) {
                Text(value)
                    .font(.titleSB20)
                    .tracking(-0.2)
                    .foregroundColor(.gr800)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(unit)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr700)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(10)
    }

    // MARK: - 영양소 카드 (제목 없는 그리드만)
    // Frame 2147224706: column, center, gap:8, padding 12 20, w:370, h:110, radius:10
    // Frame 2147224728: row, alignItems:center, w:360, h:80
    private var nutrientCard: some View {
        HStack(spacing: 0) {
            nutrientItem(icon: "icon_kcal", label: "칼로리",   value: "2,780", color: Color(hex: "3CBDDD"), hasRightBorder: true)
            nutrientItem(icon: "icon_rice", label: "탄수화물", value: "451",   color: Color(hex: "00B78A"), hasRightBorder: true)
            nutrientItem(icon: "icon_meat", label: "단백질",   value: "70",    color: Color(hex: "DD5C3C"), hasRightBorder: true)
            nutrientItem(icon: "icon_oil",  label: "지방",     value: "77",    color: Color(hex: "FFA915"), hasRightBorder: false)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
    }

    // 90×80: 아이콘 x:32 y:4 25×25 / 값 y:37 / 라벨 y:60
    // 앞 3개에 오른쪽 구분선 (Grey/100 1px)
    private func nutrientItem(icon: String, label: String, value: String, color: Color, hasRightBorder: Bool) -> some View {
        ZStack(alignment: .top) {
            Color.clear
                .frame(maxWidth: .infinity)
                .frame(height: 80)

            Image(icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 25, height: 25)
                .offset(y: 4)

            Text(value)
                .font(.bodySB14)
                .tracking(-0.14)
                .foregroundColor(.gr800)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 21)
                .offset(y: 37)

            Text(label)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr600)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 16)
                .offset(y: 60)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .overlay(alignment: .trailing) {
            if hasRightBorder {
                Rectangle()
                    .fill(Color(hex: "EDF0F4"))
                    .frame(width: 1)
            }
        }
    }
}

#Preview {
    GluLogView()
}
