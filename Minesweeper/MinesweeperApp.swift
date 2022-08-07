//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    var settings = GameSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Game(settings: settings))
        }
    }
}
