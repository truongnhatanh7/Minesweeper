//
//  ModeView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 08/08/2022.
//

import SwiftUI

struct ModeView: View {
    @EnvironmentObject var game: Game
    @State var currentMode: Int = 10
    var body: some View {
        VStack {
            Text("Difficulty: \(currentMode)")
            VStack {
                Button {
                    currentMode = 10
                } label: {
                    Text("10 bombs")
                }
                Button {
                    currentMode = 15
                } label: {
                    Text("15 bombs")
                }
                Button {
                    currentMode = 20
                } label: {
                    Text("20 bombs")
                }
                NavigationLink {
                    GameView()
                } label: {
                    Text("Play")
                }

            }
        }
        .onAppear() {
            print("REC")
        }
        .transition(.opacity)
        .onDisappear() {
            // TODO: wait for done init -> load view
            game.settings.numBombs = currentMode
            game.board = Game.initializeBoard(settings: game.settings)
            

        }
    }
}

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
        ModeView()
    }
}
