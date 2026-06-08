import SwiftUI

// 온보딩 4 - 혈당수치 (441:6575)
struct Onboarding4BloodSugarView: View {
    @Binding var onboardingDone: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var knowsBloodSugar: Bool = true  // "알고있다" 기본 선택

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    OnboardingBackHeader { dismiss() }

                    // layout_4LV5Q7: column gap:40, padding 12 16
                    VStack(alignment: .leading, spacing: 40) {
                        OnboardingProgressBar(progress: 228.0 / 371.0)

                        Text("최근 혈당수치를 알고 있나요?")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.gr900)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: 235-(114+101)≈20pt
                    Color.clear.frame(height: 20)

                    // layout_BMJ9XJ: column gap:10, padding 12 16, y:235
                    // Frame 2147224820: 370×92 (label + 2 buttons)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("최근 혈당 수치")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr400)

                        Color.clear.frame(height: 8)

                        HStack(spacing: 16) {
                            OnboardingSelectButton(text: "알고있다", isSelected: knowsBloodSugar) {
                                knowsBloodSugar = true
                            }
                            OnboardingSelectButton(text: "잘 모르겠어요", isSelected: !knowsBloodSugar) {
                                knowsBloodSugar = false
                            }
                        }
                        .frame(height: 60)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // layout_PIW6X1: column gap:8, padding 0 16, y:351 (gap: 351-363=~12pt)
                    // 혈당 수치 입력 (항상 표시, Figma 기준)
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "EDF0F4"))
                                .frame(height: 60)
                            HStack(spacing: 4) {
                                Text("141")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                                Text("mg/dL")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .opacity(knowsBloodSugar ? 1 : 0)

                    Spacer(minLength: 200)

                    // layout_R05HWX: y:718, x:15, w:369
                    // "모르셔도 괜찮아요! \n나중에 마이페이지에서 수정할 수 있어요."
                    Group {
                        Text("모르셔도 괜찮아요! \n나중에 ")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr800)
                        + Text("마이페이지에서 수정")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.g400)
                        + Text("할 수 있어요.")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr800)
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: 369)
                    .padding(.bottom, 110)
                }
            }

            VStack(spacing: 0) {
                NavigationLink(destination: Onboarding5HealthConditionView(onboardingDone: $onboardingDone)) {
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
}

#Preview {
    NavigationStack {
        Onboarding4BloodSugarView(onboardingDone: .constant(false))
    }
}
