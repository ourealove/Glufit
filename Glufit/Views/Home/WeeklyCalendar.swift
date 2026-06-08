import SwiftUI

// Figma: 주 캘린더 (x:23, y:248)
// Row layout, gap:22pt, each day 32pt wide, VStack gap:6pt
// Each cell: day label (body_sb_14, Grey/600) + 32×32 circle area
// Circle area structure (all states): background shape + number at y:6 centered
struct WeeklyCalendar: View {
    struct DayData {
        let name: String
        let number: Int
        let state: DayState
    }

    enum DayState {
        case rest       // no circle, grey number
        case safe       // Grey/200 circle + Grey/500 number
        case danger     // ic_calendar_danger icon + Grey/500 number
        case warning    // ic_calendar_warning icon + Grey/500 number
        case today      // pink100 circle + Grey/800 bold number
    }

    // Figma snapshot: 일(24)safe, 월(25)danger, 화(26)warning, 수(27)safe, 목(28)today, 금(29)rest, 토(30)rest
    let days: [DayData] = [
        DayData(name: "일", number: 24, state: .safe),
        DayData(name: "월", number: 25, state: .danger),
        DayData(name: "화", number: 26, state: .warning),
        DayData(name: "수", number: 27, state: .safe),
        DayData(name: "목", number: 28, state: .today),
        DayData(name: "금", number: 29, state: .rest),
        DayData(name: "토", number: 30, state: .rest),
    ]

    var body: some View {
        HStack(spacing: 22) {
            ForEach(days, id: \.number) { day in
                CalendarDayCell(day: day)
            }
        }
    }
}

private struct CalendarDayCell: View {
    let day: WeeklyCalendar.DayData

    var body: some View {
        VStack(spacing: 6) {
            // Day label: body_sb_14, Grey/600
            Text(day.name)
                .font(.bodySB14)
                .tracking(-0.14)
                .foregroundColor(.gr600)
                .frame(width: 32, alignment: .center)

            // 32×32 circle area
            ZStack {
                switch day.state {
                case .rest:
                    // no background, number only
                    Color.clear.frame(width: 32, height: 32)
                    Text("\(day.number)")
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr500)

                case .safe:
                    // Grey/200 circle + number
                    Circle().fill(Color.gr200).frame(width: 32, height: 32)
                    Text("\(day.number)")
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr500)

                case .danger:
                    // ic_calendar_danger icon (30.64×32) + Grey/500 number
                    Image("ic_calendar_danger")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 31, height: 32)
                    Text("\(day.number)")
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr500)

                case .warning:
                    // ic_calendar_warning icon + Grey/500 number
                    Image("ic_calendar_warning")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 31, height: 32)
                    Text("\(day.number)")
                        .font(.bodyM14)
                        .tracking(-0.14)
                        .foregroundColor(.gr500)

                case .today:
                    // pink100 circle + Grey/800 bold number
                    Circle().fill(Color.pink100).frame(width: 32, height: 32)
                    Text("\(day.number)")
                        .font(.bodySB14)
                        .tracking(-0.14)
                        .foregroundColor(.gr800)
                }
            }
            .frame(width: 32, height: 32)
        }
        .frame(width: 32)
    }
}

#Preview {
    WeeklyCalendar()
        .padding(.horizontal, 23)
}
