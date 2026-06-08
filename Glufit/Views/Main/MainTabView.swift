import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    enum Tab { case home, glulog, fittalk, myfit }

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:    HomeView()
                case .glulog:  GluLogView()
                case .fittalk: NavigationStack { FitTalkView() }
                case .myfit:   MyFitView()
                }
            }
            .ignoresSafeArea(edges: .bottom)

            bottomBar
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private var bottomBar: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 0)
                .shadow(color: Color(white: 0.64).opacity(0.21), radius: 4, x: 0, y: -2)

            HStack(spacing: 0) {
                tabItem(.home,    activeIcon: "icon_home_01",      inactiveIcon: "icon_home_02",      label: "홈")
                tabItem(.glulog,  activeIcon: "icon_report_01",    inactiveIcon: "icon_report_02",    label: "글루로그")
                tabItem(.fittalk, activeIcon: "icon_community_01", inactiveIcon: "icon_community_02", label: "핏톡")
                tabItem(.myfit,   activeIcon: "icon_mypage_01",    inactiveIcon: "icon_mypage_02",    label: "마이핏")
            }
            .frame(height: 66)
            .background(
                Color.white
                    .shadow(color: Color(white: 0.64).opacity(0.21), radius: 4, x: 0, y: -2)
            )
            .overlay(alignment: .top) {
                Color.clear.frame(height: 0)
            }

            Color.white
                .frame(height: 24)  // home indicator 영역
        }
        .background(Color.white)
    }

    @ViewBuilder
    private func tabItem(_ tab: Tab, activeIcon: String, inactiveIcon: String, label: String) -> some View {
        let isActive = selectedTab == tab
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 0) {
                Image(isActive ? activeIcon : inactiveIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.top, 8)

                Text(label)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(isActive ? .g400 : .gr300)
                    .padding(.top, 4)

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainTabView()
}
