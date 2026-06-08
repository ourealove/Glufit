import SwiftUI
import CoreText

@main
struct GlufitApp: App {
    init() {
        ["Pretendard-SemiBold", "Pretendard-Medium", "Pretendard-Bold", "Montserrat-ExtraBold"].forEach { name in
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
