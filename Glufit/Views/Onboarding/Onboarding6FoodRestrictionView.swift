import SwiftUI

// 온보딩 6 - 먹을 수 없는 음식 (442:6680)
struct Onboarding6FoodRestrictionView: View {
    @Binding var onboardingDone: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var selected: Set<String> = ["없음"]

    private let foods: [[String]] = [
        ["유제품", "계란"],
        ["복숭아", "견과류"],
        ["갑각류", "육류"],
        ["생선",   "기타"]
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    OnboardingBackHeader { dismiss() }

                    // layout_HQAKGM: column gap:40, padding 12 16
                    VStack(alignment: .leading, spacing: 40) {
                        // 진행 바 Full (370/371 ≈ 1.0)
                        OnboardingProgressBar(progress: 370.0 / 371.0)

                        Text("먹을 수 없는 음식을 알려주세요")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.gr900)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: ~20pt
                    Color.clear.frame(height: 20)

                    // layout_R0AEJC: column gap:12, y:235
                    VStack(spacing: 12) {
                        // Frame 2147224824: "알레르기 또는 못먹는 음식" label + "없음" 버튼
                        VStack(alignment: .leading, spacing: 0) {
                            Text("알레르기 또는 못먹는 음식")
                                .font(.bodyM16)
                                .tracking(-0.16)
                                .foregroundColor(.gr400)

                            Color.clear.frame(height: 8)

                            HStack(spacing: 16) {
                                OnboardingSelectButton(text: "없음", isSelected: selected.contains("없음")) {
                                    toggleFood("없음")
                                }
                                Color.clear
                            }
                            .frame(height: 60)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)

                        // Frame 2147224833: 2열 음식 그리드 (y:12 오프셋 반영)
                        VStack(spacing: 12) {
                            ForEach(foods, id: \.self) { row in
                                HStack(spacing: 16) {
                                    ForEach(row, id: \.self) { food in
                                        OnboardingSelectButton(
                                            text: food,
                                            isSelected: selected.contains(food)
                                        ) {
                                            toggleFood(food)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 12)
                    }

                    // layout_5JNP25: y:742, x:44, w:314
                    // "선택한 음식은 추천 음식과 레시피 추천에 반영돼요."
                    Color.clear.frame(height: 40)
                    Group {
                        Text("선택한 음식은 ")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr800)
                        + Text("추천 음식과 레시피 추천에 반영돼요.")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.g400)
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: 314)
                    .padding(.bottom, 110)
                }
            }

            // 마지막 버튼: "시작하기" (Green/400 bg)
            VStack(spacing: 0) {
                Button {
                    onboardingDone = true
                } label: {
                    Text("시작하기")
                        .font(.bodySB18)
                        .tracking(-0.18)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.g400)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 17)
                .padding(.top, 12)
            }
            .frame(height: 90)
            .background(Color.white)
            .shadow(color: Color(white: 0.64).opacity(0.21), radius: 4, x: 0, y: -2)
        }
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .navigationBarHidden(true)
    }

    private func toggleFood(_ food: String) {
        if food == "없음" {
            if selected.contains("없음") {
                selected.remove("없음")
            } else {
                selected = ["없음"]
            }
        } else {
            selected.remove("없음")
            if selected.contains(food) {
                selected.remove(food)
            } else {
                selected.insert(food)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Onboarding6FoodRestrictionView(onboardingDone: .constant(false))
    }
}
