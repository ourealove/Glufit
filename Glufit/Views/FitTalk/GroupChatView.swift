import SwiftUI

struct GroupChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var inputText = ""
    @FocusState private var isInputFocused: Bool

    private enum Sender {
        case me
        case other(name: String, profile: String)
    }

    private struct ChatMessage: Identifiable {
        let id = UUID()
        let sender: Sender
        let text: String
        let time: String
    }

    private let messages: [ChatMessage] = [
        .init(sender: .other(name: "지훈 트레이너", profile: "dg_author_06"),
              text: "안녕하세요 여러분! 오늘 식단 어떻게 되세요? 🥦",
              time: "오전 10:02"),
        .init(sender: .other(name: "예진", profile: "ft_profile_02"),
              text: "저는 닭가슴살 샐러드 먹었어요 🥗",
              time: "오전 10:04"),
        .init(sender: .other(name: "민우", profile: "dg_author_07"),
              text: "저 오늘 치팅데이라서요ㅎㅎ 피자 먹었습니다",
              time: "오전 10:05"),
        .init(sender: .other(name: "지훈 트레이너", profile: "dg_author_06"),
              text: "민우님 어제도 치팅데이 아니었나요 😂",
              time: "오전 10:06"),
        .init(sender: .me,
              text: "저는 현미밥에 두부조림 먹었어요 나름 건강하게!",
              time: "오전 10:08"),
        .init(sender: .other(name: "예진", profile: "ft_profile_02"),
              text: "지연님 너무 건강하게 드셨다 👍",
              time: "오전 10:09"),
        .init(sender: .other(name: "지훈 트레이너", profile: "dg_author_06"),
              text: "다들 오늘 물 2L 목표 잊지 말아요! 수분 보충이 혈당 안정에 도움돼요 💧",
              time: "오전 10:11"),
        .init(sender: .me,
              text: "오늘 물 목표 달성했어요 💪",
              time: "오전 10:13"),
        .init(sender: .other(name: "민우", profile: "dg_author_07"),
              text: "저도 내일부터 다시 제대로 시작할게요..",
              time: "오전 10:14"),
        .init(sender: .other(name: "지훈 트레이너", profile: "dg_author_06"),
              text: "민우님 할 수 있어요! 작은 것부터 시작해요 😊",
              time: "오전 10:15"),
        .init(sender: .me,
              text: "민우님 화이팅이에요! 같이 해봐요 🔥",
              time: "오전 10:16"),
        .init(sender: .other(name: "예진", profile: "ft_profile_02"),
              text: "저녁 식단도 올려요~ 오늘 저녁도 헬시하게!",
              time: "오전 10:18"),
    ]

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider().overlay(Color(hex: "E5E8ED"))

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        dateHeader
                        LazyVStack(spacing: 0) {
                            ForEach(messages) { msg in
                                messageRow(msg)
                                    .id(msg.id)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
                .onAppear {
                    if let last = messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            inputBar
            // MainTabView 커스텀 탭바 ZStack 오버레이(90pt) - 시스템 safe area(34pt) = 56pt
            Color.clear.frame(height: 56)
        }
        .background(Color(hex: "EDF0F4"))
        .navigationBarHidden(true)
        .onTapGesture { isInputFocused = false }
    }

    // MARK: - 헤더
    private var header: some View {
        HStack(spacing: 0) {
            Button { dismiss() } label: {
                Image("ft_icon_next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .rotationEffect(.degrees(180))
            }

            Spacer()

            VStack(spacing: 2) {
                Text("식단 관리팟 💬")
                    .font(.bodySB16)
                    .tracking(-0.16)
                    .foregroundColor(.gr900)
                Text("4명")
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr500)
            }

            Spacer()

            Image(systemName: "line.3.horizontal")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.gr700)
                .frame(width: 28, height: 28)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 52)
        .background(Color.white)
        .shadow(color: Color(hex: "737373").opacity(0.15), radius: 4, x: 0, y: 2)
    }

    // MARK: - 날짜 구분선
    private var dateHeader: some View {
        HStack(spacing: 8) {
            Rectangle().fill(Color(hex: "D1D5DB")).frame(height: 1)
            Text("2026년 6월 2일")
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr500)
                .fixedSize()
            Rectangle().fill(Color(hex: "D1D5DB")).frame(height: 1)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }

    // MARK: - 메시지 행
    @ViewBuilder
    private func messageRow(_ msg: ChatMessage) -> some View {
        switch msg.sender {
        case .me:
            myBubble(msg)
        case .other(let name, let profile):
            otherBubble(msg, name: name, profile: profile)
        }
    }

    // 내 메시지 (오른쪽)
    private func myBubble(_ msg: ChatMessage) -> some View {
        HStack(alignment: .bottom, spacing: 6) {
            Spacer(minLength: 60)
            Text(msg.time)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr500)
                .padding(.bottom, 2)
            Text(msg.text)
                .font(.bodyM14)
                .tracking(-0.14)
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.g400)
                .cornerRadius(18, corners: [.topLeft, .topRight, .bottomLeft])
        }
        .padding(.bottom, 12)
    }

    // 상대방 메시지 (왼쪽)
    private func otherBubble(_ msg: ChatMessage, name: String, profile: String) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            Image(profile)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr600)

                HStack(alignment: .bottom, spacing: 6) {
                    Text(msg.text)
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr900)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(18, corners: [.topRight, .bottomLeft, .bottomRight])

                    Text(msg.time)
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.gr500)
                        .padding(.bottom, 2)
                }
            }

            Spacer(minLength: 60)
        }
        .padding(.bottom, 12)
    }

    // MARK: - 입력 바
    private var inputBar: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                TextField("메시지를 입력하세요", text: $inputText)
                    .font(.bodyM14)
                    .tracking(-0.14)
                    .foregroundColor(.gr900)
                    .focused($isInputFocused)

                if !inputText.isEmpty {
                    Button {
                        inputText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gr400)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .background(Color(hex: "F4F6F9"))
            .cornerRadius(22)

            Button {
                inputText = ""
                isInputFocused = false
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 34))
                    .foregroundColor(inputText.isEmpty ? Color.gr300 : Color.g400)
            }
            .disabled(inputText.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .shadow(color: Color(hex: "737373").opacity(0.1), radius: 4, x: 0, y: -2)
    }
}

// MARK: - 특정 모서리 cornerRadius
private extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationStack {
        GroupChatView()
    }
}
