/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: dd/mm/yyyy 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

import SwiftUI

struct AchievementView: View {
    @State var user: User
    @Binding var leaderboardViewManipulation: Int
    var body: some View {
        VStack {
            Button  {
                leaderboardViewManipulation = 0
            } label: {
                Text("GO BACK")
                    .italic()
                    .foregroundColor(Color("neonGreen"))
                    .fontWeight(.bold)
                    .padding()
            }
            
            Text("ACHIEVEMENTS")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            ScrollView {
                ForEach(user.achievements, id: \.self) { achievement in
                    AchievementRow(achievement: achievement)
                }
            }
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView(user: User(), leaderboardViewManipulation: LeaderboardView().$leaderboardViewManipulation)
    }
}
