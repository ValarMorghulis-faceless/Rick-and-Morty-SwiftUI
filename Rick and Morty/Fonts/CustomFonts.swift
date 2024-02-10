//
//  CustomFonts.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import SwiftUI

enum CustomFonts: String {
    case montserratFont = "Montserrat"
}

enum CustomFontStyle: String {
    case bold = "-Bold"
    case light = "-Light"
    case medium = "-Medium"
    case regular = "-Regular"
    case semiBold = "-SemiBold"
}

enum CustomFontSize: CGFloat {
    case h0 = 36.0
    case h1 = 32.0
    case h2 = 20.0
    case h3 = 16.0
    case h4 = 8.0
}

extension Font {
    static func customFont (
        font: CustomFonts,
        style: CustomFontStyle,
        size: CustomFontSize,
        isScaled: Bool = true
    ) -> Font {
        let fontName: String = font.rawValue + style.rawValue
        
        return Font.custom(fontName, size: size.rawValue)
    }
}
