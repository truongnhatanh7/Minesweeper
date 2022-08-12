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
            Text("LEADERBOARD")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
                .padding()
            ScrollView {
                ForEach(users, id: \.self) { user in
                    LeaderboardRowView(user: user)
                        .padding()
                }
            }
            
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
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
