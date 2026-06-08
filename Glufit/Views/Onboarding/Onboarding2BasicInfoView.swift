import SwiftUI

// 온보딩 2 - 기본정보 (357:3826)
struct Onboarding2BasicInfoView: View {
    @Binding var onboardingDone: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGender: Gender = .female

    enum Gender { case male, female }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // layout_EYHVEM: row, padding 8 16, h:52, y:62(status bar)
                    OnboardingBackHeader { dismiss() }

                    // layout_K0BJVT: column gap:40, padding 12 16
                    VStack(alignment: .leading, spacing: 40) {
                        OnboardingProgressBar(progress: 93.0 / 371.0)

                        Text("당신의 기본정보를 알려주세요")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.gr900)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: 235-(114+101) ≈ 20pt
                    Color.clear.frame(height: 20)

                    // layout_ELOBMC: column gap:10, padding 12 16
                    // Frame B6JOSE: 성별 label(y:0) + 두 버튼(y:32)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("성별")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr400)

                        Color.clear.frame(height: 8)

                        HStack(spacing: 16) {
                            OnboardingSelectButton(text: "남성", isSelected: selectedGender == .male) {
                                selectedGender = .male
                            }
                            OnboardingSelectButton(text: "여성", isSelected: selectedGender == .female) {
                                selectedGender = .female
                            }
                        }
                        .frame(height: 60)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: 363-(235+116)=12pt
                    Color.clear.frame(height: 12)

                    // layout_GKRLXU: column gap:8, padding 12 16
                    VStack(alignment: .leading, spacing: 8) {
                        Text("생년월일")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr400)

                        // Frame 2147224818: fill×60, Grey/100, radius:10
                        // "2000. 01. 01" centered (titleM20, Grey/900)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "EDF0F4"))
                                .frame(height: 60)
                            Text("2000. 01. 01")
                                .font(.titleM20)
                                .tracking(-0.2)
                                .foregroundColor(.gr900)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    Spacer(minLength: 110)
                }
            }

            // layout_34AWAK: h:90, shadow
            VStack(spacing: 0) {
                NavigationLink(destination: Onboarding3BodyInfoView(onboardingDone: $onboardingDone)) {
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
        Onboarding2BasicInfoView(onboardingDone: .constant(false))
    }
}
