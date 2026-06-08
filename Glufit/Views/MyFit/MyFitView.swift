import SwiftUI

struct MyFitView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "EDF0F4").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header

                    profileCard
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                    Color.clear.frame(height: 24)

                    sectionTitle("건강 목표 달성률")
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 8)

                    goalProgressCard
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 24)

                    sectionTitle("이번 주 평균")
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 8)

                    weeklyStatsRow
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 24)

                    sectionTitle("참여 중인 챌린지")
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 8)

                    challengeSummaryCard
                        .padding(.horizontal, 16)

                    Spacer(minLength: 110)
                }
            }
        }
    }

    // MARK: - 헤더 (FitTalk와 동일 구조: padding 8 16, h:44)
    private var header: some View {
        HStack {
            Text("Myfit")
                .font(.montserratEB30)
                .tracking(1)
                .foregroundColor(.g400)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 44)
    }

    // MARK: - 프로필 카드
    private var profileCard: some View {
        VStack(spacing: 0) {
            // 프로필 상단: 사진 + 이름 + 배지
            HStack(spacing: 16) {
                Image("dg_author_03")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.g400, lineWidth: 2))

                VStack(alignment: .leading, spacing: 6) {
                    Text("지연")
                        .font(.bodySB18)
                        .tracking(-0.18)
                        .foregroundColor(.gr900)

                    Text("GluFit Member")
                        .font(.captionM12)
                        .tracking(-0.12)
                        .foregroundColor(.g400)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.g400.opacity(0.1))
                        .cornerRadius(20)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            Divider()
                .overlay(Color(hex: "EDF0F4"))
                .padding(.horizontal, 20)

            // 요약 통계 3개
            HStack(spacing: 0) {
                profileStat(value: "3개", label: "참여 챌린지")
                    .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color(hex: "EDF0F4"))
                    .frame(width: 1, height: 36)

                profileStat(value: "14일", label: "연속 기록")
                    .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color(hex: "EDF0F4"))
                    .frame(width: 1, height: 36)

                profileStat(value: "78%", label: "목표 달성률")
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 16)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(hex: "848484").opacity(0.15), radius: 8, x: 0, y: 2)
    }

    private func profileStat(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.titleSB20)
                .tracking(-0.2)
                .foregroundColor(.gr900)
            Text(label)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr500)
        }
    }

    // MARK: - 섹션 제목
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.bodySB18)
            .tracking(-0.18)
            .foregroundColor(.gr900)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - 건강 목표 달성률 카드
    private var goalProgressCard: some View {
        VStack(spacing: 16) {
            goalProgressRow(
                label: "혈당 안정성",
                valueText: "양호",
                progress: 0.82,
                color: Color(hex: "00B78A")
            )
            Divider().overlay(Color(hex: "EDF0F4"))
            goalProgressRow(
                label: "칼로리 목표",
                valueText: "845 / 2,000 kcal",
                progress: 0.42,
                color: Color(hex: "3CBDDD")
            )
            Divider().overlay(Color(hex: "EDF0F4"))
            goalProgressRow(
                label: "운동 목표",
                valueText: "30분 / 60분",
                progress: 0.5,
                color: Color(hex: "FDCA42")
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(hex: "848484").opacity(0.15), radius: 8, x: 0, y: 2)
    }

    private func goalProgressRow(label: String, valueText: String, progress: CGFloat, color: Color) -> some View {
        VStack(spacing: 8) {
            HStack {
                Text(label)
                    .font(.bodySB14)
                    .tracking(-0.14)
                    .foregroundColor(.gr800)
                Spacer()
                Text(valueText)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr500)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "EDF0F4"))
                        .frame(height: 8)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geo.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
        }
    }

    // MARK: - 이번 주 평균 (GluLog과 동일한 statCard 스타일)
    private var weeklyStatsRow: some View {
        HStack(spacing: 8) {
            weeklyStatCard(title: "평균 혈당",   value: "138",  unit: "mg/dL")
            weeklyStatCard(title: "평균 몸무게", value: "58.3", unit: "kg")
            weeklyStatCard(title: "평균 칼로리", value: "912",  unit: "kcal")
        }
    }

    private func weeklyStatCard(title: String, value: String, unit: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.captionM12)
                .tracking(-0.12)
                .foregroundColor(.gr800)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            HStack(alignment: .lastTextBaseline, spacing: 3) {
                Text(value)
                    .font(.titleSB20)
                    .tracking(-0.2)
                    .foregroundColor(.gr800)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(unit)
                    .font(.captionM12)
                    .tracking(-0.12)
                    .foregroundColor(.gr600)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(hex: "848484").opacity(0.15), radius: 8, x: 0, y: 2)
    }

    // MARK: - 참여 중인 챌린지 요약
    private var challengeSummaryCard: some View {
        VStack(spacing: 12) {
            challengeRow(
                category: "식단",
                title: "하루 1,800kcal 이하 식단 유지",
                daysLeft: "D-3",
                progress: 0.72,
                color: Color(hex: "3CBDDD")
            )
            Divider().overlay(Color(hex: "EDF0F4"))
            challengeRow(
                category: "운동",
                title: "매일 30분 유산소 21일 챌린지",
                daysLeft: "D-8",
                progress: 0.45,
                color: Color(hex: "FDCA42")
            )
            Divider().overlay(Color(hex: "EDF0F4"))
            challengeRow(
                category: "체중",
                title: "30일 안에 목표 체중 달성하기",
                daysLeft: "D-16",
                progress: 0.3,
                color: Color(hex: "00B78A")
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(hex: "848484").opacity(0.15), radius: 8, x: 0, y: 2)
    }

    private func challengeRow(category: String, title: String, daysLeft: String, progress: CGFloat, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(category)
                    .font(.captionSB12)
                    .tracking(-0.12)
                    .foregroundColor(color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(color.opacity(0.12))
                    .cornerRadius(4)

                Text(title)
                    .font(.bodyM14)
                    .tracking(-0.14)
                    .foregroundColor(.gr800)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(daysLeft)
                    .font(.captionSB12)
                    .tracking(-0.12)
                    .foregroundColor(.gr500)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "EDF0F4"))
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geo.size.width * progress, height: 6)
                }
            }
            .frame(height: 6)
        }
    }
}

#Preview {
    MyFitView()
}
