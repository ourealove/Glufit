import SwiftUI
import Combine

private struct FTCommentItem {
    let text: String
    let profileImage: String
}

private enum ChallengeFilter: String, CaseIterable, Hashable {
    case participating = "참여중"
    case all           = "전체"
    case diet          = "식단"
    case exercise      = "운동"
    case weight        = "체중"

    var icon: String {
        switch self {
        case .participating: return "ft_filter_inprogress"
        case .all:           return "ft_filter_all"
        case .diet:          return "ft_filter_diet"
        case .exercise:      return "ft_filter_exercise"
        case .weight:        return "ft_filter_weight"
        }
    }
}

private struct ChallengeData {
    let iconName: String
    let title: String
    let members: String
    let daysLeft: String
    let progress: CGFloat
    let category: ChallengeFilter
    let isParticipating: Bool

    var progressColor: Color {
        switch category {
        case .diet:                      return Color(hex: "3CBDDD")
        case .exercise:                  return Color(hex: "FDCA42")
        case .weight:                    return Color(hex: "85ABFF")
        case .all, .participating:       return Color(hex: "00B78A")
        }
    }
}

struct FitTalkView: View {
    @State private var commentIndex = 0
    @State private var commentOpacity: Double = 1.0
    @State private var selectedFilter: ChallengeFilter = .participating

    private let commentTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    private let comments: [FTCommentItem] = [
        FTCommentItem(text: "좋아요!",        profileImage: "ft_profile_06"),
        FTCommentItem(text: "열심히 하네...", profileImage: "ft_profile_02"),
    ]

    private var allChallenges: [ChallengeData] {[
        // 식단
        ChallengeData(iconName: "ft_challenge_food_icon",   title: "7일 저당 식단",       members: "128", daysLeft: "D-4",  progress: 185/333, category: .diet,     isParticipating: true),
        ChallengeData(iconName: "ft_challenge_food_icon",   title: "아침 단백질 30g",     members: "203", daysLeft: "D-12", progress: 133/333, category: .diet,     isParticipating: false),
        ChallengeData(iconName: "ft_challenge_food_icon",   title: "음식 사진 매일 기록", members: "312", daysLeft: "D-3",  progress: 266/333, category: .diet,     isParticipating: false),
        ChallengeData(iconName: "ft_challenge_food_icon",   title: "하루 채소 5색",       members: "89",  daysLeft: "D-7",  progress:  60/333, category: .diet,     isParticipating: false),
        // 운동
        ChallengeData(iconName: "ft_challenge_muscle_icon", title: "식후 30분 걷기",      members: "101", daysLeft: "D-6",  progress:  52/333, category: .exercise, isParticipating: true),
        ChallengeData(iconName: "ft_challenge_muscle_icon", title: "주 3회 근력운동",     members: "74",  daysLeft: "D-9",  progress: 120/333, category: .exercise, isParticipating: false),
        ChallengeData(iconName: "ft_challenge_muscle_icon", title: "매일 10분 스트레칭",  members: "312", daysLeft: "D-2",  progress: 310/333, category: .exercise, isParticipating: false),
        ChallengeData(iconName: "ft_challenge_muscle_icon", title: "점심 계단 오르기",    members: "167", daysLeft: "D-5",  progress: 200/333, category: .exercise, isParticipating: false),
        // 체중
        ChallengeData(iconName: "ft_challenge_weight_icon", title: "4주 체지방 -2%",     members: "98",  daysLeft: "D-21", progress:  80/333, category: .weight,   isParticipating: false),
        ChallengeData(iconName: "ft_challenge_weight_icon", title: "매주 체중 인증하기",  members: "445", daysLeft: "D-1",  progress: 330/333, category: .weight,   isParticipating: false),
        ChallengeData(iconName: "ft_challenge_weight_icon", title: "30일 체중 기록 도전", members: "221", daysLeft: "D-8",  progress: 150/333, category: .weight,   isParticipating: false),
    ]}

    private var filteredChallenges: [ChallengeData] {
        let base: [ChallengeData]
        switch selectedFilter {
        case .participating: base = allChallenges.filter { $0.isParticipating }
        case .all:           base = allChallenges
        case .diet:          base = allChallenges.filter { $0.category == .diet }
        case .exercise:      base = allChallenges.filter { $0.category == .exercise }
        case .weight:        base = allChallenges.filter { $0.category == .weight }
        }
        return base.sorted {
            let a = Int($0.daysLeft.replacingOccurrences(of: "D-", with: "")) ?? 99
            let b = Int($1.daysLeft.replacingOccurrences(of: "D-", with: "")) ?? 99
            return a < b
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Header (y:62, h:44)
                header

                // Gap 4pt (110 - 106 = 4)
                Color.clear.frame(height: 4)

                // 친구들이 올린 식단 (y:110, padding 8 16)
                friendsDietSection

                // Gap 8pt (313 - 305 = 8)
                Color.clear.frame(height: 8)

                // 그룹 카드 (y:313)
                groupSection

                // Gap 28pt (426 - 398 = 28)
                Color.clear.frame(height: 28)

                // 핏챌린지 헤더 + 필터탭 (y:426, padding 12 0)
                fitChallengeSection

                // 챌린지 카드 목록 (y:589, padding 0 16)
                challengeCardsSection

                // 하단바 공간
                Spacer(minLength: 140)
            }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        .onReceive(commentTimer) { _ in
            withAnimation(.easeOut(duration: 0.25)) { commentOpacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    commentIndex = (commentIndex + 1) % comments.count
                }
                withAnimation(.easeIn(duration: 0.25)) { commentOpacity = 1 }
            }
        }
    }

    // MARK: - Header
    // layout_JJYQUQ: row, space-between, padding 8 16, h:44
    private var header: some View {
        HStack {
            Text("FitTalk")
                .font(.montserratEB30)
                .tracking(-0.3)
                .foregroundColor(.g400)
            Spacer()
            Image("ft_icon_plus")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 44)
    }

    // MARK: - 친구들이 올린 식단 섹션
    // layout_7RCLSL: column, gap:12, padding 8 16
    private var friendsDietSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("친구들이 올린 식단")
                .font(.bodySB18)
                .tracking(-0.18)
                .foregroundColor(.gr900)
                .frame(maxWidth: .infinity, alignment: .leading)

            foodSharingCard
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    // layout_L55BCQ: fill × 140, 절대 좌표 오버레이
    private var foodSharingCard: some View {
        ZStack(alignment: .topLeading) {
            Image("ft_sharing_bg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .clipped()

            // 프로필 + 닉네임 x:12, y:12 (layout_JS2ATA)
            HStack(spacing: 8) {
                Image("ft_profile_02")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 38, height: 38)
                    .clipShape(Circle())

                Text("예진")
                    .font(.bodySB14)
                    .tracking(-0.14)
                    .foregroundColor(.gr100)
                    .padding(.vertical, 4)
            }
            .offset(x: 12, y: 12)

            // 하트 아이콘 x:14.08, y:102 (layout_GVOJ3B)
            Image("ft_icon_heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .offset(x: 14.08, y: 102)

            // 댓글 버블 (layout_MBSK9Z) — trailing anchor, 4초 교체 애니메이션
            HStack(spacing: 6) {
                Text(comments[commentIndex].text)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr800)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 14)
                    .frame(height: 30)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .lineLimit(1)

                Image(comments[commentIndex].profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
            }
            .fixedSize(horizontal: true, vertical: false)
            .padding(.trailing, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .offset(y: 96)
            .opacity(commentOpacity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .cornerRadius(10)
        .clipped()
    }

    // MARK: - 그룹 카드 섹션
    // layout_PHRHHV: row, gap:8, padding 0 16
    private var groupSection: some View {
        HStack(spacing: 8) {
            NavigationLink(destination: DietGroupView()) {
                groupCard(
                    title: "식단 관리팟 ✨",
                    filledDots: 3, totalDots: 4,
                    tag: "식단관리", tagColor: .g400
                )
            }
            .buttonStyle(.plain)

            groupCard(
                title: "운동 인증팟 🔥",
                filledDots: 4, totalDots: 5,
                tag: "운동인증", tagColor: Color(hex: "00A2B7")
            )
        }
        .padding(.horizontal, 16)
    }

    // layout_0BI6GO: 180x85, borderRadius 10, stroke Grey/100 2px, shadow
    private func groupCard(
        title: String,
        filledDots: Int, totalDots: Int,
        tag: String, tagColor: Color
    ) -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gr100, lineWidth: 2)
                )
                .shadow(
                    color: Color(hex: "848484").opacity(0.25),
                    radius: 10, x: 0, y: 0
                )

            // 제목 (layout_IJLM5H: x:20, y:15, bodySB16, Grey/700)
            Text(title)
                .font(.bodySB16)
                .tracking(-0.16)
                .foregroundColor(.gr700)
                .offset(x: 20, y: 15)

            // 점들 (layout_TWU7EI: x:20, y:46, row gap:8, padding:8 0)
            HStack(spacing: 8) {
                ForEach(0..<totalDots, id: \.self) { i in
                    Circle()
                        .fill(i < filledDots ? Color.g400 : Color.gr200)
                        .frame(width: 8, height: 8)
                }
            }
            .offset(x: 20, y: 54)  // y:46 + 8(padding-top)

            // 키워드 태그 (layout_KAOAWP: x:116, y:54, padding 2 4)
            Text(tag)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(tagColor)
                .padding(.vertical, 2)
                .padding(.horizontal, 4)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(tagColor, lineWidth: 1)
                )
                .offset(x: 116, y: 54)
        }
        .frame(width: 180, height: 85)
    }

    // MARK: - 핏챌린지 섹션
    // layout_KTYVDY: column, center, gap:8, padding:12 0, w:402
    private var fitChallengeSection: some View {
        VStack(spacing: 8) {
            // 헤더 (layout_5RK71B: row, space-between, w:370)
            HStack {
                Text("핏챌린지")
                    .font(.bodySB18)
                    .tracking(-0.18)
                    .foregroundColor(.gr900)
                Spacer()
                HStack(spacing: 0) {
                    Text("전체보기")
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.gr600)
                    Image("ft_icon_next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
            }
            .frame(width: 370)

            // 필터 탭 (layout_YQ1YKO: row center, gap:17, padding:12 16)
            HStack(spacing: 17) {
                ForEach(ChallengeFilter.allCases, id: \.self) { filter in
                    filterTab(filter: filter)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 12)
    }

    // layout_BPYOT5: column, gap:4, w:60
    private func filterTab(filter: ChallengeFilter) -> some View {
        let isSelected = selectedFilter == filter
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedFilter = filter
            }
        } label: {
            VStack(spacing: 4) {
                filterIcon(filter: filter, isSelected: isSelected)
                Text(filter.rawValue)
                    .font(.captionSB12)
                    .tracking(-0.12)
                    .foregroundColor(isSelected ? .gr900 : .gr400)
            }
            .frame(width: 60)
        }
        .buttonStyle(.plain)
    }

    // 참여중 PNG에는 active 상태 초록 테두리가 내장되어 있어 코드로 합성
    @ViewBuilder
    private func filterIcon(filter: ChallengeFilter, isSelected: Bool) -> some View {
        if filter == .participating {
            ZStack {
                Circle().fill(Color.gr100)
                Image("ft_icon_inprogress")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
            .frame(width: 60, height: 60)
            .overlay(Circle().stroke(isSelected ? Color.g400 : Color.clear, lineWidth: 2))
        } else {
            Image(filter.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .overlay(Circle().stroke(isSelected ? Color.g400 : Color.clear, lineWidth: 2))
        }
    }

    // MARK: - 챌린지 카드 목록
    // layout_XWRACH: column, gap:10, padding 0 16
    private var challengeCardsSection: some View {
        let items = filteredChallenges
        return VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                challengeItem(
                    iconName: item.iconName,
                    title: item.title,
                    members: item.members,
                    daysLeft: item.daysLeft,
                    progress: item.progress,
                    progressColor: item.progressColor,
                    showBottomBorder: index < items.count - 1
                )
            }
        }
        .id(selectedFilter)
        .transition(.opacity)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gr100, lineWidth: 2)
        )
        .shadow(
            color: Color(hex: "848484").opacity(0.25),
            radius: 10, x: 0, y: 0
        )
        .padding(.horizontal, 16)
    }

    // layout_V09A9X: column, fill, hug, padding:16, gap:10
    // inner: layout_RQWA5X: column, center, gap:11, w:333
    private func challengeItem(
        iconName: String,
        title: String,
        members: String,
        daysLeft: String,
        progress: CGFloat,
        progressColor: Color,
        showBottomBorder: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 11) {
            // layout_PUL0QA: row, center, fill, gap:126
            HStack(spacing: 0) {
                // layout_R2AEXG: icon 30x30 + title bodySB16 (한 줄)
                HStack(spacing: 0) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text(title)
                        .font(.bodySB16)
                        .tracking(-0.16)
                        .foregroundColor(.gr700)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }
                .frame(width: 200, alignment: .leading)

                Spacer()

                // layout_C4SOXV: row, center, gap:4 (한 줄 표시)
                HStack(spacing: 4) {
                    Text("\(members)명")
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.gr500)
                        .fixedSize()
                    Rectangle()
                        .fill(Color.gr500)
                        .frame(width: 1, height: 8)
                    Text("\(daysLeft)일")
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.gr500)
                        .fixedSize()
                }
            }

            // layout_FMCTAJ: fill x 6px 진행바
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gr200)
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(progressColor)
                        .frame(width: max(0, geo.size.width * progress), height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottom) {
            if showBottomBorder {
                Rectangle()
                    .fill(Color.gr100)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        FitTalkView()
    }
}
