//
//  Color.swift
//  Color
//
//  Created by Sergio Cardoso on 21/08/21.
//

import Foundation
import SwiftUI


extension Color {
    
static let theme = ColorTheme()
static let launch = LaunchTheme()
    
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

