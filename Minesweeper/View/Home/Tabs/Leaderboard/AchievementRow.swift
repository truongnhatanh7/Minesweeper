//
//  AchievementRow.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

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
    
    func convertAchievementToScore(achievement: String) -> String {
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