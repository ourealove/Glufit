import SwiftUI
import Combine

private struct CommentItem {
    let text: String
    let profileImage: String
}

struct FoodCarousel: View {
    @State private var selectedIndex = 1
    @State private var isFlipped = false
    @State private var dragOffset: CGFloat = 0
    @State private var isEveningExpanded = false
    @State private var showCamera = false
    @State private var showPrediction = false
    @State private var selectedFoodKeyword: String? = nil
    @State private var selectedMorningKeyword: String? = nil

    // 점심 카드 댓글
    @State private var lunchCommentIndex = 0
    @State private var lunchCommentOpacity: Double = 1.0
    private let lunchCommentTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    private let lunchComments: [CommentItem] = [
        CommentItem(text: "회원님 뭐하세요..?", profileImage: "img_home_profile_01"),
        CommentItem(text: "다이어트중 아니야?",  profileImage: "img_home_profile_02"),
    ]

    // 아침 카드 댓글
    @State private var morningCommentIndex = 0
    @State private var morningCommentOpacity: Double = 1.0
    private let morningCommentTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    private let morningComments: [CommentItem] = [
        CommentItem(text: "아침은 괜찮네요..",  profileImage: "img_home_profile_01"),
        CommentItem(text: "직접 만든거얌?",    profileImage: "img_home_profile_02"),
    ]

    private let foodKeywordInfo: [String: KeywordInfo] = [
        "피자":    KeywordInfo(text: "908 kcal 고칼로리, +18 mg/dL 혈당위험높음",  color: .red100),
        "탄산음료": KeywordInfo(text: "320 kcal 당분과다, +12 mg/dL 혈당주의필요",  color: .yellow100),
        "치킨":    KeywordInfo(text: "540 kcal 고칼로리, +9 mg/dL 혈당주의있음",   color: .yellow100),
    ]
    private let morningKeywordInfo: [String: KeywordInfo] = [
        "계란토스트": KeywordInfo(text: "280 kcal 적정칼로리, +5 mg/dL 혈당안정적", color: .g400),
    ]

    private let cardW: CGFloat = 322
    private let cardH: CGFloat = 354
    private let cardSpacing: CGFloat = 14
    private let elevation: CGFloat = 12

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                HStack(spacing: cardSpacing) {
                    ForEach(0..<3, id: \.self) { i in
                        cardView(for: i)
                            .offset(y: i == selectedIndex ? -elevation : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedIndex)
                            .onTapGesture {
                                guard i == selectedIndex else { return }
                                if i == 1 {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                                        isFlipped.toggle()
                                    }
                                } else if i == 2, !isEveningExpanded {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        isEveningExpanded = true
                                    }
                                }
                            }
                    }
                }
                .offset(x: baseOffset(for: selectedIndex, in: geo.size.width) + dragOffset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = cardW * 0.25
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                if value.translation.width < -threshold, selectedIndex < 2 {
                                    selectedIndex += 1
                                } else if value.translation.width > threshold, selectedIndex > 0 {
                                    selectedIndex -= 1
                                }
                                dragOffset = 0
                            }
                        }
                )
            }
            .frame(height: cardH + elevation)

            paginationDots
        }
        .onReceive(lunchCommentTimer) { _ in
            withAnimation(.easeOut(duration: 0.25)) { lunchCommentOpacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                var t = Transaction(); t.disablesAnimations = true
                withTransaction(t) { lunchCommentIndex = (lunchCommentIndex + 1) % lunchComments.count }
                withAnimation(.easeIn(duration: 0.25)) { lunchCommentOpacity = 1 }
            }
        }
        .onReceive(morningCommentTimer) { _ in
            withAnimation(.easeOut(duration: 0.25)) { morningCommentOpacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                var t = Transaction(); t.disablesAnimations = true
                withTransaction(t) { morningCommentIndex = (morningCommentIndex + 1) % morningComments.count }
                withAnimation(.easeIn(duration: 0.25)) { morningCommentOpacity = 1 }
            }
        }
        .onChange(of: selectedIndex) { _, _ in
            if isFlipped {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                    isFlipped = false
                }
            }
            if isEveningExpanded {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isEveningExpanded = false
                }
            }
            selectedFoodKeyword = nil
            selectedMorningKeyword = nil
        }
        .fullScreenCover(isPresented: $showCamera) { MealCameraView(isPresented: $showCamera) }
        .fullScreenCover(isPresented: $showPrediction) { MealPredictionView(isPresented: $showPrediction) }
    }

    private func baseOffset(for index: Int, in width: CGFloat) -> CGFloat {
        let step = cardW + cardSpacing
        let centerX = (width - cardW) / 2
        return centerX - CGFloat(index) * step
    }

    // MARK: - Card Dispatch

    @ViewBuilder
    private func cardView(for index: Int) -> some View {
        if index == 0 {
            morningRegistCard.frame(width: cardW, height: cardH)
        } else if index == 1 {
            flipCard.frame(width: cardW, height: cardH)
        } else {
            eveningCard.frame(width: cardW, height: cardH)
        }
    }

    // MARK: - Evening Card

    private var eveningCard: some View {
        Group {
            if isEveningExpanded {
                eveningExpandedCard
            } else {
                notRegistCard(
                    prompt: "오늘 저녁 메뉴를 기록해보세요",
                    bottomText: "저녁에는 가벼운 저당 식단을 추천드려요"
                )
            }
        }
    }

    private var eveningExpandedCard: some View {
        VStack(spacing: 8) {
            EveningOptionCard(
                title: "입력으로 예측하기",
                subtitle: "먹기 전 혈당과 칼로리, 대체음식을 확인해보세요",
                greyIcon: "img_home_carousel_prediction_grey",
                colorIcon: "img_home_carousel_prediction_color"
            ) {
                showPrediction = true
            }

            EveningOptionCard(
                title: "식사 기록하기",
                subtitle: "사진 촬영으로 식단을 간편하게 기록해보세요",
                greyIcon: "img_home_carousel_filming_grey",
                colorIcon: "img_home_carousel_filming_color"
            ) {
                showCamera = true
            }
        }
        .padding(20)
        .frame(width: cardW, height: cardH)
        .background(Color(hex: "EDF0F4"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(red: 115/255, green: 115/255, blue: 115/255).opacity(0.25), radius: 4, x: 0, y: 3)
    }

    // MARK: - Flip Card

    private var flipCard: some View {
        ZStack {
            foodCardFront
                .opacity(isFlipped ? 0 : 1)

            foodCardBack
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0), perspective: 0.5)
                .opacity(isFlipped ? 1 : 0)
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
    }

    // MARK: - Food Card Front (322×354)

    private var foodCardFront: some View {
        let info = selectedFoodKeyword.flatMap { foodKeywordInfo[$0] }
        let bottomText = info?.text ?? "고혈당 음식으로 인해 혈당 상승 위험이 높아요"
        let textColor = info?.color ?? .gr600
        return VStack(spacing: 0) {
            foodImageSection
            bottomInfoBar(score: "14", text: bottomText, textColor: textColor)
        }
        .frame(width: cardW, height: cardH)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(white: 0.4).opacity(0.25), radius: 4, x: 0, y: 1)
    }

    // MARK: - Food Card Back (추천 대체 음식)

    private struct KeywordInfo {
        let text: String
        let color: Color
    }

    private struct MenuItemData {
        let imageName: String
        let foodName: String
        let calories: String
        let bloodSugar: String
        let buttonType: ButtonType
        enum ButtonType { case nearbyStore, recipe }
    }

    private let menuItems: [MenuItemData] = [
        MenuItemData(imageName: "img_home_card_menu_01", foodName: "샐러디 클래식 치킨 샌드위치", calories: "469",   bloodSugar: "12", buttonType: .nearbyStore),
        MenuItemData(imageName: "img_home_card_menu_02", foodName: "또띠아 닭가슴살 피자",        calories: "420",   bloodSugar: "8",  buttonType: .recipe),
        MenuItemData(imageName: "img_home_card_menu_03", foodName: "구운로미연어 포케타코",        calories: "272.5", bloodSugar: "6",  buttonType: .nearbyStore),
        MenuItemData(imageName: "img_home_card_menu_04", foodName: "크리미 어니언 치킨랩",        calories: "325.2", bloodSugar: "8",  buttonType: .nearbyStore),
        MenuItemData(imageName: "img_home_card_menu_05", foodName: "통밀 또띠아 페퍼로니 피자",   calories: "450",   bloodSugar: "10", buttonType: .recipe),
        MenuItemData(imageName: "img_home_card_menu_06", foodName: "타코 쉬림프 랩",             calories: "501",   bloodSugar: "13", buttonType: .nearbyStore),
        MenuItemData(imageName: "img_home_card_menu_07", foodName: "멕시칸 랩",                  calories: "607",   bloodSugar: "12", buttonType: .nearbyStore),
    ]

    private var foodCardBack: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // Header: 그라데이션 배경, 77pt
                ZStack(alignment: .topLeading) {
                    LinearGradient(
                        colors: [.gradientStart, .gradientEnd],
                        startPoint: .leading, endPoint: .trailing
                    )

                    // "추천 대체 음식" 타이틀 (y:12, x:24)
                    HStack(spacing: 4) {
                        Image("ic_star_four")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                        Text("추천 대체 음식 ")
                            .font(.bodySB14)
                            .tracking(-0.14)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 12)
                    .padding(.leading, 24)

                    // 키워드 필 (y:41, x:24)
                    HStack(spacing: 10) {
                        backKeywordPill("피자", isActive: true)
                        backKeywordPill("치킨", isActive: false)
                        backKeywordPill("탄산음료", isActive: false)
                    }
                    .padding(.top, 41)
                    .padding(.leading, 24)
                }
                .frame(width: cardW, height: 77)
                .clipShape(.rect(topLeadingRadius: 10, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 10))

                // 스크롤 가능한 메뉴 리스트 (277pt)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(menuItems.enumerated()), id: \.offset) { _, item in
                            menuItemRow(item)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(width: cardW, height: 277)
                .background(Color.white)
                .clipShape(.rect(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 0))
            }

            // 하단 페이드 그라데이션 오버레이
            LinearGradient(
                colors: [.clear, .white],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 48)
            .allowsHitTesting(false)
        }
        .frame(width: cardW, height: cardH)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(red: 115/255, green: 115/255, blue: 115/255).opacity(0.25), radius: 4, x: 0, y: 3)
    }

    private func backKeywordPill(_ text: String, isActive: Bool) -> some View {
        Text(text)
            .font(.captionM12)
            .tracking(-0.12)
            .foregroundColor(isActive ? .g600 : .white)
            .padding(.horizontal, 14)
            .padding(.vertical, 4)
            .frame(height: 24)
            .background(isActive ? Color.white : Color.g800)
            .clipShape(Capsule())
    }

    private func menuItemRow(_ item: MenuItemData) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                // 음식 이미지
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 89.7, height: 74)
                    .background(Color.pink100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // 정보 영역
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.foodName)
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.gr900)
                        .lineLimit(2)
                        .frame(width: 132, alignment: .leading)

                    HStack(spacing: 2) {
                        HStack(spacing: 0) {
                            Text(item.calories)
                                .font(.captionM12)
                                .tracking(-0.12)
                                .foregroundColor(.gr700)
                            Text("kcal")
                                .font(.captionM12)
                                .tracking(-0.12)
                                .foregroundColor(.gr700)
                        }
                        Text("/")
                            .font(.captionM12)
                            .foregroundColor(.gr700)
                        HStack(spacing: 0) {
                            Text(item.bloodSugar)
                                .font(.captionM12)
                                .tracking(-0.12)
                                .foregroundColor(.gr700)
                            Text("mg/dL")
                                .font(.captionM12)
                                .tracking(-0.12)
                                .foregroundColor(.gr700)
                        }
                    }

                    // 버튼
                    switch item.buttonType {
                    case .nearbyStore:
                        Text("근처매장보기")
                            .font(.captionM12)
                            .tracking(-0.12)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.g500)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    case .recipe:
                        Text("레시피보기")
                            .font(.captionM12)
                            .tracking(-0.12)
                            .foregroundColor(.g700)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.g200)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                .frame(width: 172, height: 70, alignment: .topLeading)

                Spacer(minLength: 0)
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }

    // MARK: - Not Regist Card (home_carousel_not regist, 231:1988)
    // Top: 322×284, absolute. img at (0,0). Text at x:66 y:198 w:189.
    // Bottom: row center, padding 8px 18px, h:70, white bg.

    private func notRegistCard(prompt: String, bottomText: String) -> some View {
        VStack(spacing: 0) {
            // home_carousel_top (layout_Z7HOAJ): absolute, h:284
            ZStack(alignment: .topLeading) {
                Image("img_home_carousel_00")
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardW, height: 284)
                    .clipped()

                Text(prompt)
                    .font(.bodySB16)
                    .tracking(-0.16)
                    .foregroundColor(.gr700)
                    .multilineTextAlignment(.center)
                    .frame(width: 189, alignment: .center)
                    .offset(x: 66, y: 198)
            }
            .frame(width: cardW, height: 284)

            // home_carousel_bottom (layout_YW77YX): row center, padding 8px 18px, h:70
            HStack {
                Text(bottomText)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr600)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .padding(.horizontal, 18)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(red: 115/255, green: 115/255, blue: 115/255).opacity(0.25), radius: 4, x: 0, y: 3)
    }

    // MARK: - 아침 등록 카드 (322×354)

    private var morningRegistCard: some View {
        let info = selectedMorningKeyword.flatMap { morningKeywordInfo[$0] }
        let bottomText = info?.text ?? "식단은 좋지만 더 든든한 식사가 필요해요"
        let textColor = info?.color ?? .gr600
        return VStack(spacing: 0) {
            morningImageSection
            bottomInfoBar(score: "80", text: bottomText, textColor: textColor)
        }
        .frame(width: cardW, height: cardH)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(white: 0.4).opacity(0.25), radius: 4, x: 0, y: 1)
    }

    private var morningImageSection: some View {
        ZStack(alignment: .topLeading) {
            Image("img_home_carousel_03")
                .resizable()
                .scaledToFill()
                .frame(width: cardW, height: 284)
                .clipped()

            LinearGradient(
                colors: [Color(red: 7/255, green: 7/255, blue: 7/255), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .opacity(0.5)
            .frame(width: cardW, height: 284)

            interactiveKeywordPill("계란토스트", selected: $selectedMorningKeyword)
                .padding(.top, 41)
                .padding(.leading, 114)

            morningCommunityComment
                .fixedSize(horizontal: true, vertical: false)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(y: 232)
        }
        .frame(width: cardW, height: 284)
    }

    private var morningCommunityComment: some View {
        let comment = morningComments[morningCommentIndex]
        return HStack(spacing: 8) {
            Text(comment.text)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr800)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .frame(height: 30)
                .background(Color.white)
                .clipShape(Capsule())

            Image(comment.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
                .clipShape(Circle())
        }
        .opacity(morningCommentOpacity)
    }

    // MARK: - 공통 하단 정보 바

    private func bottomInfoBar(score: String, text: String, textColor: Color = .gr600) -> some View {
        ZStack(alignment: .topLeading) {
            Color.white

            ZStack {
                Image("ic_ai_feedback")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38.2, height: 40)

                Text(score)
                    .font(.bodySB14)
                    .tracking(-0.14)
                    .foregroundColor(.white)
                    .offset(x: 1, y: 6)
            }
            .frame(width: 38.2, height: 40)
            .padding(.top, 15)
            .padding(.leading, 20)

            Text(text)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(textColor)
                .frame(width: 223, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.top, 27)
                .padding(.leading, 75)
        }
        .frame(width: cardW, height: 70)
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 10,
                bottomTrailingRadius: 10,
                topTrailingRadius: 0
            )
        )
    }

    // MARK: - 음식 이미지 섹션 (322×284)

    private var foodImageSection: some View {
        ZStack(alignment: .topLeading) {
            Image("img_home_food_02")
                .resizable()
                .scaledToFill()
                .frame(width: cardW, height: 284)
                .clipped()

            LinearGradient(
                colors: [Color(red: 7/255, green: 7/255, blue: 7/255), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .opacity(0.5)
            .frame(width: cardW, height: 284)

            interactiveKeywordPill("탄산음료", selected: $selectedFoodKeyword)
                .padding(.top, 41)
                .padding(.leading, 114)

            interactiveKeywordPill("피자", selected: $selectedFoodKeyword)
                .padding(.top, 123)
                .padding(.leading, 35)

            interactiveKeywordPill("치킨", selected: $selectedFoodKeyword)
                .padding(.top, 165)
                .padding(.leading, 253)

            communityComment
                .fixedSize(horizontal: true, vertical: false)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(y: 232)
        }
        .frame(width: cardW, height: 284)
    }

    private func interactiveKeywordPill(_ text: String, selected: Binding<String?>) -> some View {
        let isSelected = selected.wrappedValue == text
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selected.wrappedValue = selected.wrappedValue == text ? nil : text
            }
        } label: {
            Text(text)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr100)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .frame(height: 24)
                .background(isSelected ? Color(hex: "00A57C") : Color.black.opacity(0.5))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private var communityComment: some View {
        let comment = lunchComments[lunchCommentIndex]
        return HStack(spacing: 8) {
            Text(comment.text)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr800)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .frame(height: 30)
                .background(Color.white)
                .clipShape(Capsule())

            Image(comment.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
                .clipShape(Circle())
        }
        .opacity(lunchCommentOpacity)
    }


    // MARK: - 페이지네이션 날씨 이모지 인디케이터

    private let indicatorActive = ["ic_indicator_day_active", "ic_indicator_evening_active", "ic_indicator_night_active"]
    private let indicatorInactive = ["ic_indicator_day_inactive", "ic_indicator_evening_inactive", "ic_indicator_night_inactive"]

    private var paginationDots: some View {
        HStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { i in
                Image(i == selectedIndex ? indicatorActive[i] : indicatorInactive[i])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedIndex)
            }
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Evening Option Card (press-highlighted sub-card)

private struct EveningOptionCard: View {
    let title: String
    let subtitle: String
    let greyIcon: String
    let colorIcon: String
    let action: () -> Void

    @GestureState private var isPressed = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background + border
            RoundedRectangle(cornerRadius: 10)
                .fill(isPressed ? Color.g100 : Color.white)
            RoundedRectangle(cornerRadius: 10)
                .stroke(isPressed ? Color.g400 : Color.clear, lineWidth: 2)

            // Title
            Text(title)
                .font(.bodySB16)
                .tracking(-0.16)
                .foregroundColor(isPressed ? Color(hex: "00523E") : .gr900)
                .frame(width: 190, alignment: .leading)
                .offset(x: 20, y: 20)

            // Subtitle
            Text(subtitle)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(isPressed ? .g700 : .gr400)
                .frame(width: 160, alignment: .leading)
                .lineLimit(2)
                .offset(x: 20, y: 48)

            // Icon
            Image(isPressed ? colorIcon : greyIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .offset(x: 190, y: 57)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 153)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in state = true }
                .onEnded { value in
                    let dist = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                    if dist < 20 { action() }
                }
        )
    }
}

#Preview {
    FoodCarousel()
}
