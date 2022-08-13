//
//  AchievementView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

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
