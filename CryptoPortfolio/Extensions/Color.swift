//
//  Color.swift
//  CryptoPortfolio
//
//  Created by white4ocolate on 01.10.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenCustomColor")
    let red = Color("RedCustomColor")
    let purple = Color("PurpleCustomColor")
    let secondaryText = Color("SecondaryTextColor")
}
