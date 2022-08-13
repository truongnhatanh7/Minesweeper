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

struct AchievementRow: View {
    @State var achievement: String
    var body: some View {
        HStack {
            VStack {
                Text(convertAchievementToScore(achievement: achievement))
                    .italic()
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .frame(width: 40, height: 40)
            .padding()
            .background(Color("neonGreen"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 8)
            Spacer()
            Text("/ \(achievement) /")
                .fontWeight(.bold)
        }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("text"), lineWidth: 2)
            )
            .padding(.horizontal, 68)
            .padding(2)
    }
    
    private func convertAchievementToScore(achievement: String) -> String {
        if achievement.contains("Newbie") {
            return "10"
        } else if achievement.contains("Good try") {
            return "30"
        } else if achievement.contains("Half way") {
            return "50"
        } else if achievement == "80 is so LIT" {
            return "80"
        } else if achievement == "Sweepar god" {
            return "100"
        }
        return ""
    }
}

struct AchievementRow_Previews: PreviewProvider {
    static var previews: some View {
        AchievementRow(achievement: "Sweepar god")
    }
}
