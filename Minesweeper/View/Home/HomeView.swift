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
import AVKit

struct HomeView: View {
    @State var viewManipulation: Int = 0
    @EnvironmentObject var game: Game
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "background")
    }
    var body: some View {
        if viewManipulation == 0 {
            PreHomeLoginView(viewManipulation: $viewManipulation)
        } else if viewManipulation == 1 {
            PreHomeRegisterView(viewManipulation: $viewManipulation)
        } else {
            TabView {
                ModeView(viewManipulation: $viewManipulation)
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Play")
                    }
                
                LeaderboardView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Leaderboard")
                    }
                
                HelpView()
                    .tabItem {
                        Image(systemName: "questionmark.circle")
                        Text("Help")
                    }
            }
            .accentColor(Color("neonGreen"))
            .onAppear() {
                game.backgroundAudioManager.playSounds(soundfile: "background", type: ".mp3", repeatNum: -1)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
