//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Yaroslav Yurev on 8/24/23.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingPage()
        }
    }
}

extension Color {
    // Primary color #495E57:
    static let oliveGreen = Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
    // Primary color #F4CE14:
    static let mangoYellow = Color(red: 244 / 255, green: 206 / 255, blue: 20 / 255)
}
