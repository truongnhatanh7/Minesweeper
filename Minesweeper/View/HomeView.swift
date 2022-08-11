//
//  HomeView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

import SwiftUI

struct HomeView: View {
    @State var viewManipulation: Int = 0
    @EnvironmentObject var game: Game
    @EnvironmentObject var realmManager: RealmManager
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
                // TODO: Add leaderboard, how to play
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
