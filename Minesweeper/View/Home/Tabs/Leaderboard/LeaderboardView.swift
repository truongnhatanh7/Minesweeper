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
