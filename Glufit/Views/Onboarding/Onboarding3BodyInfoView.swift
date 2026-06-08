import SwiftUI

// 온보딩 3 - 신체정보 (437:6526)
struct Onboarding3BodyInfoView: View {
    @Binding var onboardingDone: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    OnboardingBackHeader { dismiss() }

                    // layout_Y1XKNJ: column gap:40, padding 12 16
                    VStack(alignment: .leading, spacing: 40) {
                        OnboardingProgressBar(progress: 164.0 / 371.0)

                        Text("당신의 신체정보를 알려주세요")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.gr900)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: 235-(114+101)≈20pt
                    Color.clear.frame(height: 20)

                    // layout_HFBNQ2: column gap:8, padding 12 16, y:235
                    // Frame 2147224818: 키 (fill×60, Grey/100, "160 cm" 중앙)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("키")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr400)

                        // layout_2M52K4: x:153, y:17 → "160" + "cm" inline (titleM20, Grey/900)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "EDF0F4"))
                                .frame(height: 60)
                            HStack(spacing: 4) {
                                Text("160")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                                Text("cm")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: 363-(235+116)=12pt
                    Color.clear.frame(height: 12)

                    // layout_EVMR7B: column gap:8, padding 12 16, y:363
                    VStack(alignment: .leading, spacing: 8) {
                        Text("몸무게")
                            .font(.bodyM16)
                            .tracking(-0.16)
                            .foregroundColor(.gr400)

                        // "62 kg" 중앙 (titleM20, Grey/900)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "EDF0F4"))
                                .frame(height: 60)
                            HStack(spacing: 4) {
                                Text("62")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                                Text("kg")
                                    .font(.titleM20)
                                    .tracking(-0.2)
                                    .foregroundColor(.gr900)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    Spacer(minLength: 110)
                }
            }

            VStack(spacing: 0) {
                NavigationLink(destination: Onboarding4BloodSugarView(onboardingDone: $onboardingDone)) {
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
        Onboarding3BodyInfoView(onboardingDone: .constant(false))
    }
}
