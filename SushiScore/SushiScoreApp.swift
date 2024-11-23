//
//  SushiScoreApp.swift
//  SushiScore
//
//  Created by 保坂篤志 on 2024/11/22.
//

import SwiftUI
import SwiftData

@main
struct SushiScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Score.self])
        }
    }
}
