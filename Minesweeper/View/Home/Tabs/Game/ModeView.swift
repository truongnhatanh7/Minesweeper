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
    
    @Binding var viewManipulation: Int
    @State var isPlaying: Bool = false
    var body: some View {
        if isPlaying {
            GameView(isPlaying: $isPlaying, numBombs: $currentMode)
        } else {
            VStack {
                Text("Welcome back \(game.currentUsername)")
                Text("Difficulty: \(currentMode)")
                VStack {
                    Button {
                        isPlaying = true
                        currentMode = 10
                        game.initializeBoard(numBombs: 10)
                    } label: {
                        Text("10 bombs")
                    }
                    Button {
                        isPlaying = true
                        currentMode = 15
                        game.initializeBoard(numBombs: 15)
                    } label: {
                        Text("15 bombs")
                    }
                    Button {
                        isPlaying = true
                        currentMode = 20
                        game.initializeBoard(numBombs: 20)
                    } label: {
                        Text("20 bombs")
                    }
                    
                    if game.canContinue {
                        Button {
                            isPlaying = true
                            game.initializePrevBoard()
                        } label: {
                            Text("Continue")
                        }
                    }

                    Button {
                        viewManipulation = 0
                    } label: {
                        Text("Log out")
                    }
                }
            }
            .transition(.opacity)
            .onAppear() {
                let user = game.localRealm!.object(ofType: User.self, forPrimaryKey: game.currentUserId)
                game.canContinue = user?.canContinue ?? false
            }
        }

    }
}

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ModeView(viewManipulation: HomeView().$viewManipulation)
    }
}
