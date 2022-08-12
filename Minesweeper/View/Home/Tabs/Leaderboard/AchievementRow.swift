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
//            VStack {
//                if achievement.contains("Newbie") {
//                    Text("10")
//
//                } else if achievement.contains("Good try") {
//                    Text("30")
//
//                } else if achievement.contains("Half way") {
//                    Text("50")
//
//                } else if achievement == "80 is so LIT" {
//                    Text("80")
//
//                } else if achievement == "Sweepar god" {
//                    Text("100")
//                }
//            }
//            .padding()
//            .frame(width: 50, height: 50)
//            .background(Color("neonGreen"))
//            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("/ \(achievement) /")
                .fontWeight(.bold)
                .padding()
        }
        .padding()
    }
}

struct AchievementRow_Previews: PreviewProvider {
    static var previews: some View {
        AchievementRow(achievement: "Sweepar god")
    }
}
