import SwiftUI

struct MealCameraView: View {
    @Binding var isPresented: Bool
    @State private var selectedZoom: ZoomLevel = .x1

    enum ZoomLevel: String, CaseIterable {
        case x05 = ".5"
        case x1  = "1x"
        case x2  = "2"
        case x3  = "3"
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            // Camera viewfinder area
            cameraViewfinder

            // Top bar: back + flash (safe area 아래에 배치됨)
            topBar

            // Zoom controls + shutter row
            VStack(spacing: 0) {
                Spacer()
                zoomControls
                    .padding(.bottom, 20)
                bottomControls
                    .padding(.bottom, 32)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Camera viewfinder

    private var cameraViewfinder: some View {
        ZStack {
            Color.black
            Rectangle()
                .fill(Color(white: 0.12))
                .frame(maxWidth: .infinity)
                .frame(height: 450)
                .offset(y: 0)
        }
        .ignoresSafeArea()
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            Button { isPresented = false } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
            }
            Spacer()
            Button {} label: {
                Image(systemName: "bolt.slash.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(height: 44)
    }

    // MARK: - Zoom controls

    private var zoomControls: some View {
        HStack(spacing: 2) {
            ForEach(ZoomLevel.allCases, id: \.self) { zoom in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedZoom = zoom
                    }
                } label: {
                    Text(zoom.rawValue)
                        .font(.bodyM16)
                        .tracking(-0.16)
                        .foregroundColor(zoom == selectedZoom ? .yellow100 : .white)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(zoom == selectedZoom ? Color.gr900 : Color.clear)
                        )
                }
            }
        }
    }

    // MARK: - Bottom controls (gallery thumbnail + shutter)

    private var bottomControls: some View {
        HStack(spacing: 0) {
            // Gallery thumbnail
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(white: 0.25))
                .frame(width: 51, height: 51)

            Spacer()

            // Shutter button
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                Circle()
                    .stroke(Color.white.opacity(0.4), lineWidth: 4)
                    .frame(width: 112, height: 112)
            }

            Spacer()

            // Placeholder to balance HStack (same width as thumbnail)
            Color.clear.frame(width: 51, height: 51)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MealCameraView(isPresented: .constant(true))
}
