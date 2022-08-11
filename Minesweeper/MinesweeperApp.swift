//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI
import RealmSwift

@main
struct MinesweeperApp: SwiftUI.App {
    var settings = GameSettings()
//    var realmManager = RealmManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Game(settings: settings))
//                .environmentObject(RealmManager())
        }
    }
}
