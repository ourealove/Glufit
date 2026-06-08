import SwiftUI

// 온보딩 5 - 건강 특이사항 (442:6627)
struct Onboarding5HealthConditionView: View {
    @Binding var onboardingDone: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var selected: Set<String> = ["과체중/비만"]

    private let conditions: [[String]] = [
        ["당뇨", "고혈압"],
        ["고지혈증", "과체중/비만"],
        ["심혈관 질환", "신장 질환"],
        ["지방간", "기타"]
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    OnboardingBackHeader { dismiss() }

                    // layout_U5EVFJ: column gap:40, padding 12 16
                    VStack(alignment: .leading, spacing: 40) {
                        OnboardingProgressBar(progress: 289.0 / 371.0)

                        Text("건강 특이사항이 있다면 알려주세요")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.gr900)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: ~20pt
                    Color.clear.frame(height: 20)

                    // layout_BF80CG: column gap:12, y:235
                    VStack(spacing: 12) {
                        // Frame 2147224824: column gap:10, padding 12 16
                        // "건강 특이사항" label + "없음" 단독 버튼 (177×60, 왼쪽)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("건강 특이사항")
                                .font(.bodyM16)
                                .tracking(-0.16)
                                .foregroundColor(.gr400)

                            Color.clear.frame(height: 8)

                            HStack(spacing: 16) {
                                OnboardingSelectButton(text: "없음", isSelected: selected.contains("없음")) {
                                    toggleCondition("없음")
                                }
                                Color.clear // 오른쪽 빈 공간
                            }
                            .frame(height: 60)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)

                        // Frame 2147224832: 2열 그리드 (x:16/x:209, y:12/84/156/228)
                        // 각 행 높이 60, 행간 gap 12 / 상단 12pt 오프셋
                        VStack(spacing: 12) {
                            ForEach(conditions, id: \.self) { row in
                                HStack(spacing: 16) {
                                    ForEach(row, id: \.self) { condition in
                                        OnboardingSelectButton(
                                            text: condition,
                                            isSelected: selected.contains(condition)
                                        ) {
                                            toggleCondition(condition)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 12)
                    }

                    Spacer(minLength: 110)
                }
            }

            VStack(spacing: 0) {
                NavigationLink(destination: Onboarding6FoodRestrictionView(onboardingDone: $onboardingDone)) {
                    Text("다음")
                        .font(.bodySB18)
                        .tracking(-0.18)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gr900)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
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

    private func toggleCondition(_ condition: String) {
        if condition == "없음" {
            if selected.contains("없음") {
                selected.remove("없음")
            } else {
                selected = ["없음"]
            }
        } else {
            selected.remove("없음")
            if selected.contains(condition) {
                selected.remove(condition)
            } else {
                selected.insert(condition)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Onboarding5HealthConditionView(onboardingDone: .constant(false))
    }
}
