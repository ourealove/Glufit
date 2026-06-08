import SwiftUI

// 온보딩 1 - 회원가입/로그인 (357:3825)
// layout_32D2Z3: 402×874, white
struct Onboarding1LoginView: View {
    @Binding var onboardingDone: Bool
    @State private var showPassword = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // layout_P8QU4O: column center gap:16, padding 0 16, y:144
                    // safe area top: 144-62=82pt from content top
                    Color.clear.frame(height: 82)

                    VStack(spacing: 16) {
                        Text("더 건강한 한 끼의 시작")
                            .font(.titleSB24)
                            .tracking(-0.24)
                            .foregroundColor(.g400)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)

                        Image("splash_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180.81, height: 43.39)
                    }
                    .padding(.horizontal, 16)

                    // gap: y:288 - (144+~91) ≈ 53pt
                    Color.clear.frame(height: 53)

                    // layout_GH6KGX: column gap:12, padding 12 16, y:288
                    VStack(spacing: 12) {
                        // 아이디 입력 (370×60)
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gr200, lineWidth: 1)
                                )
                                .frame(height: 60)
                            Text("아이디 입력")
                                .font(.bodyM16)
                                .tracking(-0.16)
                                .foregroundColor(.gr400)
                                .offset(x: 16, y: 17)
                        }
                        .frame(height: 60)

                        // 비밀번호 입력 (370×60) with eye icon at x:330, y:17
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gr200, lineWidth: 1)
                                )
                                .frame(height: 60)
                            Text("비밀번호 입력")
                                .font(.bodyM16)
                                .tracking(-0.16)
                                .foregroundColor(.gr400)
                                .offset(x: 16, y: 17)
                            Button { showPassword.toggle() } label: {
                                Image("ob_icon_eye")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .offset(x: 330, y: 17)
                        }
                        .frame(height: 60)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // layout_EHN4XN: column gap:10, padding 12 16, y:444 (gap=0)
                    VStack(spacing: 10) {
                        Button {
                            onboardingDone = true
                        } label: {
                            Text("로그인")
                                .font(.bodySB18)
                                .tracking(-0.18)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.g400)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // layout_24091P: row center gap:7, padding 12 16, y:518 (gap=0)
                    // 아이디 찾기 | 비밀번호 찾기 | 회원가입
                    HStack(spacing: 7) {
                        Button {} label: {
                            Text("아이디 찾기")
                                .font(.bodyM14)
                                .tracking(-0.14)
                                .foregroundColor(.gr800)
                        }
                        .frame(width: 113, height: 20)

                        Rectangle()
                            .fill(Color.gr200)
                            .frame(width: 1, height: 16)

                        Button {} label: {
                            Text("비밀번호 찾기")
                                .font(.bodyM14)
                                .tracking(-0.14)
                                .foregroundColor(.gr800)
                        }
                        .frame(width: 113, height: 20)

                        Rectangle()
                            .fill(Color.gr200)
                            .frame(width: 1, height: 16)

                        NavigationLink {
                            Onboarding2BasicInfoView(onboardingDone: $onboardingDone)
                        } label: {
                            Text("회원가입")
                                .font(.bodyM14)
                                .tracking(-0.14)
                                .foregroundColor(.gr800)
                        }
                        .frame(width: 113, height: 20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    // gap: y:610 - y:562 = 48pt
                    Color.clear.frame(height: 48)

                    // layout_FCOOMF: column center gap:20, padding 0 16, y:610
                    VStack(spacing: 20) {
                        // 간편 로그인하기 (bodyM14, Grey/500) with divider lines
                        // layout_7BJ2DJ: fill × 21
                        ZStack {
                            HStack {
                                Rectangle().fill(Color.gr200).frame(height: 1)
                                Spacer()
                                Rectangle().fill(Color.gr200).frame(height: 1)
                            }
                            Text("간편 로그인하기")
                                .font(.bodyM14)
                                .tracking(-0.14)
                                .foregroundColor(.gr500)
                                .padding(.horizontal, 8)
                                .background(Color.white)
                        }

                        // layout_F3AB40: row center gap:14, w:336
                        HStack(spacing: 14) {
                            socialButton("ob_social_kakao")
                            socialButton("ob_social_naver")
                            socialButton("ob_social_apple")
                            socialButton("ob_social_meta")
                            socialButton("ob_social_google")
                        }
                        .frame(width: 336)
                    }
                    .padding(.horizontal, 16)

                    Spacer(minLength: 60)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func socialButton(_ name: String) -> some View {
        Button {} label: {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
        }
    }
}

#Preview {
    NavigationStack {
        Onboarding1LoginView(onboardingDone: .constant(false))
    }
}
