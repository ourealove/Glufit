import SwiftUI

struct ContentView: View {
    @State private var splashDone = false
    @State private var onboardingDone = false

    var body: some View {
        if !splashDone {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.4)) {
                            splashDone = true
                        }
                    }
                }
        } else if onboardingDone {
            MainTabView()
        } else {
            NavigationStack {
                Onboarding1LoginView(onboardingDone: $onboardingDone)
            }
        }
    }
}

#Preview {
    ContentView()
}
