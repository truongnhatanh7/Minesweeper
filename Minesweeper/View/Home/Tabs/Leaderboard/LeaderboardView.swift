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
    @State var leaderboardViewManipulation = 0
    @State var user: User = User()
    
    var body: some View {
        VStack {
            if leaderboardViewManipulation == 0 {
                VStack(alignment: .center) {
                    Text("LEADERBOARD")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("text"))
                        .padding()
                    ScrollView {
                        ForEach(users, id: \.self) { user in
                            LeaderboardRowView(user: user, currentUser: self.$user, leaderboardViewManipulation: $leaderboardViewManipulation)
                                .padding()
                        }

                    }
                    Spacer()
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
            } else if leaderboardViewManipulation == 1 {
                AchievementView(user: self.user, leaderboardViewManipulation: $leaderboardViewManipulation)
            }
            Spacer()
        }
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(user: User())
    }
}
