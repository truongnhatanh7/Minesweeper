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

struct GameModalView: View {
    @EnvironmentObject var game: Game
    @State var content: String
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(content)")
                .italic()
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        .frame(width: game.settings.squareSize * 10, height: game.settings.squareSize * 10, alignment: .center)
        .background(Color("neonGreen"))
    }
}

struct GameModalView_Previews: PreviewProvider {
    static var previews: some View {
        GameModalView(content: "Win")
    }
}
