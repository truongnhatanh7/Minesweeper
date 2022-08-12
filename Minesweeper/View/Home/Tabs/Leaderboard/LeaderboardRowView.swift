//
//  LeaderboardRowView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 11/08/2022.
//

import SwiftUI

struct LeaderboardRowView: View {
    var user: User
    var body: some View {
        HStack {
            Text("\(user.username)")
            Spacer()
            Text("\(user.highscore)")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color("text"), lineWidth: 1)
        )
    }
}

struct LeaderboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRowView(user: User())
    }
}
