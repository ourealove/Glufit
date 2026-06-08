import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "glulog_graph_all" asset catalog image resource.
    static let glulogGraphAll = DeveloperToolsSupport.ImageResource(name: "glulog_graph_all", bundle: resourceBundle)

    /// The "glulog_graph_kcal" asset catalog image resource.
    static let glulogGraphKcal = DeveloperToolsSupport.ImageResource(name: "glulog_graph_kcal", bundle: resourceBundle)

    /// The "glulog_graph_mgdl" asset catalog image resource.
    static let glulogGraphMgdl = DeveloperToolsSupport.ImageResource(name: "glulog_graph_mgdl", bundle: resourceBundle)

    /// The "glulog_graph_weight" asset catalog image resource.
    static let glulogGraphWeight = DeveloperToolsSupport.ImageResource(name: "glulog_graph_weight", bundle: resourceBundle)

    /// The "ic_ai_feedback" asset catalog image resource.
    static let icAiFeedback = DeveloperToolsSupport.ImageResource(name: "ic_ai_feedback", bundle: resourceBundle)

    /// The "ic_calendar_danger" asset catalog image resource.
    static let icCalendarDanger = DeveloperToolsSupport.ImageResource(name: "ic_calendar_danger", bundle: resourceBundle)

    /// The "ic_calendar_warning" asset catalog image resource.
    static let icCalendarWarning = DeveloperToolsSupport.ImageResource(name: "ic_calendar_warning", bundle: resourceBundle)

    /// The "ic_indicator_day_active" asset catalog image resource.
    static let icIndicatorDayActive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_day_active", bundle: resourceBundle)

    /// The "ic_indicator_day_inactive" asset catalog image resource.
    static let icIndicatorDayInactive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_day_inactive", bundle: resourceBundle)

    /// The "ic_indicator_evening_active" asset catalog image resource.
    static let icIndicatorEveningActive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_evening_active", bundle: resourceBundle)

    /// The "ic_indicator_evening_inactive" asset catalog image resource.
    static let icIndicatorEveningInactive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_evening_inactive", bundle: resourceBundle)

    /// The "ic_indicator_night_active" asset catalog image resource.
    static let icIndicatorNightActive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_night_active", bundle: resourceBundle)

    /// The "ic_indicator_night_inactive" asset catalog image resource.
    static let icIndicatorNightInactive = DeveloperToolsSupport.ImageResource(name: "ic_indicator_night_inactive", bundle: resourceBundle)

    /// The "ic_star_four" asset catalog image resource.
    static let icStarFour = DeveloperToolsSupport.ImageResource(name: "ic_star_four", bundle: resourceBundle)

    /// The "icon_community_01" asset catalog image resource.
    static let iconCommunity01 = DeveloperToolsSupport.ImageResource(name: "icon_community_01", bundle: resourceBundle)

    /// The "icon_community_02" asset catalog image resource.
    static let iconCommunity02 = DeveloperToolsSupport.ImageResource(name: "icon_community_02", bundle: resourceBundle)

    /// The "icon_home_01" asset catalog image resource.
    static let iconHome01 = DeveloperToolsSupport.ImageResource(name: "icon_home_01", bundle: resourceBundle)

    /// The "icon_home_02" asset catalog image resource.
    static let iconHome02 = DeveloperToolsSupport.ImageResource(name: "icon_home_02", bundle: resourceBundle)

    /// The "icon_home_bell" asset catalog image resource.
    static let iconHomeBell = DeveloperToolsSupport.ImageResource(name: "icon_home_bell", bundle: resourceBundle)

    /// The "icon_kcal" asset catalog image resource.
    static let iconKcal = DeveloperToolsSupport.ImageResource(name: "icon_kcal", bundle: resourceBundle)

    /// The "icon_meat" asset catalog image resource.
    static let iconMeat = DeveloperToolsSupport.ImageResource(name: "icon_meat", bundle: resourceBundle)

    /// The "icon_mypage_01" asset catalog image resource.
    static let iconMypage01 = DeveloperToolsSupport.ImageResource(name: "icon_mypage_01", bundle: resourceBundle)

    /// The "icon_mypage_02" asset catalog image resource.
    static let iconMypage02 = DeveloperToolsSupport.ImageResource(name: "icon_mypage_02", bundle: resourceBundle)

    /// The "icon_oil" asset catalog image resource.
    static let iconOil = DeveloperToolsSupport.ImageResource(name: "icon_oil", bundle: resourceBundle)

    /// The "icon_report_01" asset catalog image resource.
    static let iconReport01 = DeveloperToolsSupport.ImageResource(name: "icon_report_01", bundle: resourceBundle)

    /// The "icon_report_02" asset catalog image resource.
    static let iconReport02 = DeveloperToolsSupport.ImageResource(name: "icon_report_02", bundle: resourceBundle)

    /// The "icon_rice" asset catalog image resource.
    static let iconRice = DeveloperToolsSupport.ImageResource(name: "icon_rice", bundle: resourceBundle)

    /// The "icon_share" asset catalog image resource.
    static let iconShare = DeveloperToolsSupport.ImageResource(name: "icon_share", bundle: resourceBundle)

    /// The "img_carousel_score_warning" asset catalog image resource.
    static let imgCarouselScoreWarning = DeveloperToolsSupport.ImageResource(name: "img_carousel_score_warning", bundle: resourceBundle)

    /// The "img_home_card_menu_01" asset catalog image resource.
    static let imgHomeCardMenu01 = DeveloperToolsSupport.ImageResource(name: "img_home_card_menu_01", bundle: resourceBundle)

    /// The "img_home_card_menu_02" asset catalog image resource.
    static let imgHomeCardMenu02 = DeveloperToolsSupport.ImageResource(name: "img_home_card_menu_02", bundle: resourceBundle)

    /// The "img_home_carousel_00" asset catalog image resource.
    static let imgHomeCarousel00 = DeveloperToolsSupport.ImageResource(name: "img_home_carousel_00", bundle: resourceBundle)

    /// The "img_home_food_02" asset catalog image resource.
    static let imgHomeFood02 = DeveloperToolsSupport.ImageResource(name: "img_home_food_02", bundle: resourceBundle)

    /// The "img_home_profile_01" asset catalog image resource.
    static let imgHomeProfile01 = DeveloperToolsSupport.ImageResource(name: "img_home_profile_01", bundle: resourceBundle)

    /// The "img_home_profile_02" asset catalog image resource.
    static let imgHomeProfile02 = DeveloperToolsSupport.ImageResource(name: "img_home_profile_02", bundle: resourceBundle)

    /// The "img_home_top_card_danger" asset catalog image resource.
    static let imgHomeTopCardDanger = DeveloperToolsSupport.ImageResource(name: "img_home_top_card_danger", bundle: resourceBundle)

    /// The "logo_glufit" asset catalog image resource.
    static let logoGlufit = DeveloperToolsSupport.ImageResource(name: "logo_glufit", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "glulog_graph_all" asset catalog image.
    static var glulogGraphAll: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .glulogGraphAll)
#else
        .init()
#endif
    }

    /// The "glulog_graph_kcal" asset catalog image.
    static var glulogGraphKcal: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .glulogGraphKcal)
#else
        .init()
#endif
    }

    /// The "glulog_graph_mgdl" asset catalog image.
    static var glulogGraphMgdl: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .glulogGraphMgdl)
#else
        .init()
#endif
    }

    /// The "glulog_graph_weight" asset catalog image.
    static var glulogGraphWeight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .glulogGraphWeight)
#else
        .init()
#endif
    }

    /// The "ic_ai_feedback" asset catalog image.
    static var icAiFeedback: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icAiFeedback)
#else
        .init()
#endif
    }

    /// The "ic_calendar_danger" asset catalog image.
    static var icCalendarDanger: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icCalendarDanger)
#else
        .init()
#endif
    }

    /// The "ic_calendar_warning" asset catalog image.
    static var icCalendarWarning: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icCalendarWarning)
#else
        .init()
#endif
    }

    /// The "ic_indicator_day_active" asset catalog image.
    static var icIndicatorDayActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorDayActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_day_inactive" asset catalog image.
    static var icIndicatorDayInactive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorDayInactive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_evening_active" asset catalog image.
    static var icIndicatorEveningActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorEveningActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_evening_inactive" asset catalog image.
    static var icIndicatorEveningInactive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorEveningInactive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_night_active" asset catalog image.
    static var icIndicatorNightActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorNightActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_night_inactive" asset catalog image.
    static var icIndicatorNightInactive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icIndicatorNightInactive)
#else
        .init()
#endif
    }

    /// The "ic_star_four" asset catalog image.
    static var icStarFour: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icStarFour)
#else
        .init()
#endif
    }

    /// The "icon_community_01" asset catalog image.
    static var iconCommunity01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconCommunity01)
#else
        .init()
#endif
    }

    /// The "icon_community_02" asset catalog image.
    static var iconCommunity02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconCommunity02)
#else
        .init()
#endif
    }

    /// The "icon_home_01" asset catalog image.
    static var iconHome01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconHome01)
#else
        .init()
#endif
    }

    /// The "icon_home_02" asset catalog image.
    static var iconHome02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconHome02)
#else
        .init()
#endif
    }

    /// The "icon_home_bell" asset catalog image.
    static var iconHomeBell: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconHomeBell)
#else
        .init()
#endif
    }

    /// The "icon_kcal" asset catalog image.
    static var iconKcal: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconKcal)
#else
        .init()
#endif
    }

    /// The "icon_meat" asset catalog image.
    static var iconMeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconMeat)
#else
        .init()
#endif
    }

    /// The "icon_mypage_01" asset catalog image.
    static var iconMypage01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconMypage01)
#else
        .init()
#endif
    }

    /// The "icon_mypage_02" asset catalog image.
    static var iconMypage02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconMypage02)
#else
        .init()
#endif
    }

    /// The "icon_oil" asset catalog image.
    static var iconOil: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconOil)
#else
        .init()
#endif
    }

    /// The "icon_report_01" asset catalog image.
    static var iconReport01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconReport01)
#else
        .init()
#endif
    }

    /// The "icon_report_02" asset catalog image.
    static var iconReport02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconReport02)
#else
        .init()
#endif
    }

    /// The "icon_rice" asset catalog image.
    static var iconRice: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconRice)
#else
        .init()
#endif
    }

    /// The "icon_share" asset catalog image.
    static var iconShare: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .iconShare)
#else
        .init()
#endif
    }

    /// The "img_carousel_score_warning" asset catalog image.
    static var imgCarouselScoreWarning: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgCarouselScoreWarning)
#else
        .init()
#endif
    }

    /// The "img_home_card_menu_01" asset catalog image.
    static var imgHomeCardMenu01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeCardMenu01)
#else
        .init()
#endif
    }

    /// The "img_home_card_menu_02" asset catalog image.
    static var imgHomeCardMenu02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeCardMenu02)
#else
        .init()
#endif
    }

    /// The "img_home_carousel_00" asset catalog image.
    static var imgHomeCarousel00: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeCarousel00)
#else
        .init()
#endif
    }

    /// The "img_home_food_02" asset catalog image.
    static var imgHomeFood02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeFood02)
#else
        .init()
#endif
    }

    /// The "img_home_profile_01" asset catalog image.
    static var imgHomeProfile01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeProfile01)
#else
        .init()
#endif
    }

    /// The "img_home_profile_02" asset catalog image.
    static var imgHomeProfile02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeProfile02)
#else
        .init()
#endif
    }

    /// The "img_home_top_card_danger" asset catalog image.
    static var imgHomeTopCardDanger: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgHomeTopCardDanger)
#else
        .init()
#endif
    }

    /// The "logo_glufit" asset catalog image.
    static var logoGlufit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logoGlufit)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "glulog_graph_all" asset catalog image.
    static var glulogGraphAll: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .glulogGraphAll)
#else
        .init()
#endif
    }

    /// The "glulog_graph_kcal" asset catalog image.
    static var glulogGraphKcal: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .glulogGraphKcal)
#else
        .init()
#endif
    }

    /// The "glulog_graph_mgdl" asset catalog image.
    static var glulogGraphMgdl: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .glulogGraphMgdl)
#else
        .init()
#endif
    }

    /// The "glulog_graph_weight" asset catalog image.
    static var glulogGraphWeight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .glulogGraphWeight)
#else
        .init()
#endif
    }

    /// The "ic_ai_feedback" asset catalog image.
    static var icAiFeedback: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icAiFeedback)
#else
        .init()
#endif
    }

    /// The "ic_calendar_danger" asset catalog image.
    static var icCalendarDanger: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icCalendarDanger)
#else
        .init()
#endif
    }

    /// The "ic_calendar_warning" asset catalog image.
    static var icCalendarWarning: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icCalendarWarning)
#else
        .init()
#endif
    }

    /// The "ic_indicator_day_active" asset catalog image.
    static var icIndicatorDayActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorDayActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_day_inactive" asset catalog image.
    static var icIndicatorDayInactive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorDayInactive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_evening_active" asset catalog image.
    static var icIndicatorEveningActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorEveningActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_evening_inactive" asset catalog image.
    static var icIndicatorEveningInactive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorEveningInactive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_night_active" asset catalog image.
    static var icIndicatorNightActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorNightActive)
#else
        .init()
#endif
    }

    /// The "ic_indicator_night_inactive" asset catalog image.
    static var icIndicatorNightInactive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icIndicatorNightInactive)
#else
        .init()
#endif
    }

    /// The "ic_star_four" asset catalog image.
    static var icStarFour: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icStarFour)
#else
        .init()
#endif
    }

    /// The "icon_community_01" asset catalog image.
    static var iconCommunity01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconCommunity01)
#else
        .init()
#endif
    }

    /// The "icon_community_02" asset catalog image.
    static var iconCommunity02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconCommunity02)
#else
        .init()
#endif
    }

    /// The "icon_home_01" asset catalog image.
    static var iconHome01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconHome01)
#else
        .init()
#endif
    }

    /// The "icon_home_02" asset catalog image.
    static var iconHome02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconHome02)
#else
        .init()
#endif
    }

    /// The "icon_home_bell" asset catalog image.
    static var iconHomeBell: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconHomeBell)
#else
        .init()
#endif
    }

    /// The "icon_kcal" asset catalog image.
    static var iconKcal: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconKcal)
#else
        .init()
#endif
    }

    /// The "icon_meat" asset catalog image.
    static var iconMeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconMeat)
#else
        .init()
#endif
    }

    /// The "icon_mypage_01" asset catalog image.
    static var iconMypage01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconMypage01)
#else
        .init()
#endif
    }

    /// The "icon_mypage_02" asset catalog image.
    static var iconMypage02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconMypage02)
#else
        .init()
#endif
    }

    /// The "icon_oil" asset catalog image.
    static var iconOil: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconOil)
#else
        .init()
#endif
    }

    /// The "icon_report_01" asset catalog image.
    static var iconReport01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconReport01)
#else
        .init()
#endif
    }

    /// The "icon_report_02" asset catalog image.
    static var iconReport02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconReport02)
#else
        .init()
#endif
    }

    /// The "icon_rice" asset catalog image.
    static var iconRice: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconRice)
#else
        .init()
#endif
    }

    /// The "icon_share" asset catalog image.
    static var iconShare: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .iconShare)
#else
        .init()
#endif
    }

    /// The "img_carousel_score_warning" asset catalog image.
    static var imgCarouselScoreWarning: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgCarouselScoreWarning)
#else
        .init()
#endif
    }

    /// The "img_home_card_menu_01" asset catalog image.
    static var imgHomeCardMenu01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeCardMenu01)
#else
        .init()
#endif
    }

    /// The "img_home_card_menu_02" asset catalog image.
    static var imgHomeCardMenu02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeCardMenu02)
#else
        .init()
#endif
    }

    /// The "img_home_carousel_00" asset catalog image.
    static var imgHomeCarousel00: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeCarousel00)
#else
        .init()
#endif
    }

    /// The "img_home_food_02" asset catalog image.
    static var imgHomeFood02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeFood02)
#else
        .init()
#endif
    }

    /// The "img_home_profile_01" asset catalog image.
    static var imgHomeProfile01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeProfile01)
#else
        .init()
#endif
    }

    /// The "img_home_profile_02" asset catalog image.
    static var imgHomeProfile02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeProfile02)
#else
        .init()
#endif
    }

    /// The "img_home_top_card_danger" asset catalog image.
    static var imgHomeTopCardDanger: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgHomeTopCardDanger)
#else
        .init()
#endif
    }

    /// The "logo_glufit" asset catalog image.
    static var logoGlufit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logoGlufit)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

