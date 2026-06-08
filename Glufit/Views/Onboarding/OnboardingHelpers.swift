import SwiftUI

// MARK: - 진행 바 (각 화면별 progress: 93/371, 164/371, 228/371, 289/371, 370/371)
struct OnboardingProgressBar: View {
    let progress: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.gr200)
                    .frame(height: 6)
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.g400)
                    .frame(width: geo.size.width * progress, height: 6)
            }
        }
        .frame(height: 6)
    }
}

// MARK: - 공통 헤더 (뒤로가기)
// layout_EYHVEM: row, alignItems:center, gap:4, padding 8 16, h:52
struct OnboardingBackHeader: View {
    let onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image("ft_icon_next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .rotationEffect(.degrees(180))
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 52)
    }
}

// MARK: - 공통 하단 버튼 바
// layout_34AWAK: y:784, h:90 / 버튼: x:17 y:12, 368×50, radius:10
struct OnboardingBottomBar: View {
    let label: String
    let bgColor: Color
    let action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Color.gr100
                .frame(height: 1)
            Button(action: action) {
                Text(label)
                    .font(.bodySB18)
                    .tracking(-0.18)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(bgColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 17)
            .padding(.top, 12)
        }
        .frame(height: 90)
        .background(Color.white)
        .shadow(color: Color(white: 0.64).opacity(0.21), radius: 4, x: 0, y: -2)
    }
}

// MARK: - 선택 버튼 (Default/Selected)
// Default: white bg, Grey/200 stroke 2px, radius:10 / Selected: white bg, Green/400 stroke 2px, radius:10
struct OnboardingSelectButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.bodyM18)
                .tracking(-0.18)
                .foregroundColor(isSelected ? .g400 : .gr400)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.g400 : Color.gr200, lineWidth: 2)
                )
        }
        .buttonStyle(.plain)
    }
}
