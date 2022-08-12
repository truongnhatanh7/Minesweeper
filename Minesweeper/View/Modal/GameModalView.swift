//
//  GameModalView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

import SwiftUI

struct GameModalView: View {
    @EnvironmentObject var game: Game
    @State var content: String
    
    var body: some View {
        VStack {
            Spacer()
            Text("/ \(content) /")
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
