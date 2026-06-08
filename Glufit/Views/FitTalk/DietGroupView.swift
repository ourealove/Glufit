import SwiftUI
import Combine

private struct CommentItem {
    let text: String
    let profileImage: String
}

struct DietGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showGroupChat = false

    var body: some View {
        VStack(spacing: 0) {
            header
            Color.clear.frame(height: 12)
            navTabBar
            ScrollView(showsIndicators: false) {
                postsSection
                Spacer(minLength: 90)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .navigationDestination(isPresented: $showGroupChat) {
            GroupChatView()
        }
    }

    // MARK: - 헤더
    private var header: some View {
        HStack {
            Button { dismiss() } label: {
                Image("ft_icon_next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .rotationEffect(.degrees(180))
            }

            Spacer()

            Text("식단 관리팟 ✨")
                .font(.bodySB16)
                .tracking(-0.16)
                .foregroundColor(.gr700)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .frame(height: 34)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.g400, lineWidth: 1)
                )

            Spacer()

            Button { showGroupChat = true } label: {
                Image("ft_icon_chat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 52)
        .background(Color.white)
        .shadow(color: Color(hex: "737373").opacity(0.25), radius: 4, x: 0, y: 3)
    }

    // MARK: - 네비게이션 탭 바
    private var navTabBar: some View {
        HStack(spacing: 13.33) {
            Image("ic_indicator_day_inactive")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Image("ic_indicator_evening_active")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Image("ic_indicator_night_inactive")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    // MARK: - 게시물 목록
    private var postsSection: some View {
        VStack(spacing: 8) {
            PostCardView(
                imageName: "dg_sharing_01",
                authorProfile: "dg_author_06",
                nickname: "지훈 트레이너",
                isCaptain: true,
                text: "여러분 식단 올리세요",

                comments: [
                    CommentItem(text: "넹..그것만 드세요?", profileImage: "dg_comment_profile_02")
                ]
            )
            PostCardView(
                imageName: "ft_sharing_bg",
                authorProfile: "ft_profile_02",
                nickname: "예진",
                isCaptain: false,
                text: nil,

                comments: [
                    CommentItem(text: "좋아요!",        profileImage: "ft_profile_06"),
                    CommentItem(text: "열심히 하네...", profileImage: "ft_profile_02")
                ]
            )
            PostCardView(
                imageName: "dg_sharing_00",
                authorProfile: "dg_author_07",
                nickname: "민우",
                isCaptain: false,
                text: nil,

                comments: [
                    CommentItem(text: "민우님 식단 올리세여", profileImage: "ft_profile_06"),
                    CommentItem(text: "잠?",              profileImage: "dg_author_03")
                ]
            )
            PostCardView(
                imageName: "dg_sharing_03",
                authorProfile: "dg_author_03",
                nickname: "지연",
                isCaptain: false,
                text: "크흠..ㅎㅎ",

                comments: [
                    CommentItem(text: "회원님 뭐하세요..?",  profileImage: "ft_profile_06"),
                    CommentItem(text: "다이어트 중 아니야?", profileImage: "ft_profile_02")
                ]
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - 게시물 카드
private struct PostCardView: View {
    let imageName: String
    let authorProfile: String
    let nickname: String
    let isCaptain: Bool
    let text: String?
    let comments: [CommentItem]

    @State private var isLiked = false
    @State private var commentIndex = 0
    @State private var commentOpacity: Double = 1.0

    private let commentTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 140)
                    .clipped()

                Color.black.opacity(0.3)
                    .frame(width: geo.size.width, height: 140)

                if let text = text, !text.isEmpty {
                    Text(text)
                        .font(.bodySB16)
                        .tracking(-0.16)
                        .foregroundColor(.white)
                        .frame(width: geo.size.width, alignment: .center)
                        .offset(y: 58)
                }

                HStack(spacing: 4) {
                    HStack(spacing: 8) {
                        Image(authorProfile)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 38, height: 38)
                            .clipShape(Circle())

                        Text(nickname)
                            .font(.bodySB14)
                            .tracking(-0.14)
                            .foregroundColor(.gr100)
                            .padding(.vertical, 4)
                    }

                    if isCaptain {
                        Image("ft_icon_flag")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16)
                    }
                }
                .offset(x: 12, y: 12)

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { isLiked.toggle() }
                } label: {
                    Image(isLiked ? "ft_icon_heart_active" : "ft_icon_heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .offset(x: 14.08, y: 102)

                // 댓글 버블: trailing anchor → 텍스트 길이 변화 시 프사 위치 고정
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
                // fixedSize: 자연 너비 사용 → frame trailing에 고정
                .fixedSize(horizontal: true, vertical: false)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(y: 96)
                .opacity(commentOpacity)
            }
            .frame(width: geo.size.width, height: 140)
            .cornerRadius(10)
            .clipped()
        }
        .frame(height: 140)
        .onReceive(commentTimer) { _ in
            guard comments.count > 1 else { return }
            withAnimation(.easeOut(duration: 0.25)) { commentOpacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                // layout 변경은 애니메이션 없이 즉시 교체 (opacity 0일 때)
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    commentIndex = (commentIndex + 1) % comments.count
                }
                withAnimation(.easeIn(duration: 0.25)) { commentOpacity = 1 }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DietGroupView()
    }
}
