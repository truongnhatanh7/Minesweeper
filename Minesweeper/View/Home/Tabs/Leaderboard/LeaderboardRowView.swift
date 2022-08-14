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

struct LeaderboardRowView: View {
    @State var user: User
    @Binding var currentUser: User
    @Binding var leaderboardViewManipulation: Int
    var body: some View {
        Button  {
            currentUser = user
            leaderboardViewManipulation = 1
        } label: {
            HStack {
                Text("\(user.username)")
                    .foregroundColor(Color("text"))
                Spacer()
                Text("\(user.highscore)")
                    .foregroundColor(Color("text"))
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color("text"), lineWidth: 1)
            )
        }
    }
}

struct LeaderboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRowView(user: User(), currentUser: LeaderboardView().$user, leaderboardViewManipulation: LeaderboardView().$leaderboardViewManipulation)
    }
}
