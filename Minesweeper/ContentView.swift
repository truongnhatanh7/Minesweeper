/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: Game
    var body: some View {
        HomeView()
            .frame(
                minWidth: game.settings.minWidth,
                maxWidth: game.settings.maxWidth,
                minHeight: game.settings.minHeight,
                maxHeight: game.settings.maxHeight,
                  alignment: .center
                )
            .background(Color("background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
