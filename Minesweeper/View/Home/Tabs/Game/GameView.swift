//
//  GameView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    @Binding var isPlaying: Bool
    @Binding var numBombs: Int
    var body: some View {
        ZStack {
            if !game.settings.isProcessing {
                VStack(spacing: 0) {
                    Button  {
                        isPlaying = false
                    } label: {
                        Text("Return")
                    }

                    Text("Total bombs: \(numBombs)")
                        .padding()
                        .font(.title)
                        .clipShape(Capsule())
                        
                    HStack {
                        Text("Score: \(game.score)")
                            .padding()
                        Spacer()
                        Text("Flag: \(game.flagCount)")
                            .padding()
                        
                    }

                    ForEach(0..<game.board.count, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<game.board[row].count, id: \.self) { col in
                                CellView(cell: game.board[row][col])
                            }
                        }
                    }

                }
                .transition(.opacity)
            } else {
                Text("Loading...")
            }
        }
        .transition(.opacity)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { output in
            if !game.isLose {
                game.saveStateBeforeExit(currentUsername: game.currentUsername, board: game.board)
            }
            
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    private static var gameSettings = GameSettings()
    static var previews: some View {
        let home = HomeView()
        let mode = ModeView(viewManipulation: home.$viewManipulation)
        
        GameView(isPlaying: mode.$isPlaying, numBombs: mode.$currentMode)
            .environmentObject(Game(settings: gameSettings))
    }
}
