//
//  LeaderboardView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 11/08/2022.
//

import SwiftUI
import RealmSwift

struct LeaderboardView: View {
    @State var users: [User] = []
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Leaderboard")
            ForEach(users, id: \.self) { user in
                LeaderboardRowView(user: user)
            }
        }
        .onAppear() {
            users = Array(game.getUsers()).sorted(by: { $0.highscore > $1.highscore })
        }
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
