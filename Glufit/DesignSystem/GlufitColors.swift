import SwiftUI

extension Color {
    // Primary Green
    static let g100 = Color(hex: "B8F1E3")
    static let g200 = Color(hex: "91E9D3")
    static let g300 = Color(hex: "5DD7B9")
    static let g400 = Color(hex: "00B78A")  // Brand
    static let g500 = Color(hex: "00A57C")
    static let g600 = Color(hex: "00926E")
    static let g700 = Color(hex: "008968")
    static let g800 = Color(hex: "006E53")

    // Gray
    static let gr100 = Color(hex: "E2E6EA")
    static let gr200 = Color(hex: "D5DADF")
    static let gr300 = Color(hex: "BCC4CC")
    static let gr400 = Color(hex: "959CA3")
    static let gr500 = Color(hex: "788087")
    static let gr600 = Color(hex: "666E74")
    static let gr700 = Color(hex: "4A5156")
    static let gr800 = Color(hex: "36393C")
    static let gr900 = Color(hex: "202223")

    // Secondary
    static let pink100 = Color(hex: "FEE7F1")
    static let red100   = Color(hex: "FF384C")
    static let red200   = Color(hex: "C71220")
    static let yellow100 = Color(hex: "FFA915")
    static let yellow200 = Color(hex: "FF6012")

    // Gradient 01: Green500 → Green300 (90deg, left→right)
    static let gradientStart = Color(hex: "00A57C")
    static let gradientEnd   = Color(hex: "5DD7B9")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
