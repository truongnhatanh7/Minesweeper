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
    var body: some View {
        ZStack {
            if !game.settings.isProcessing {
                VStack(spacing: 0) {
                    Button  {
                        isPlaying = false
                    } label: {
                        Text("CHANGE MODE")
                            .italic()
                            .fontWeight(.bold)
                    }
                    Spacer()

                    Text("BOMBS: \(game.settings.numBombs)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                        
                        
                    HStack {
                        Text("SCORE: \(game.score)")
                            .italic()
                            .fontWeight(.bold)
                            .modifier(ButtonModifier())
                        Spacer()
                        Text("FLAG: \(game.flagCount)")
                            .italic()
                            .fontWeight(.bold)
                            .modifier(ButtonModifier())
                        
                    }
                    .padding()
                    
                    Spacer()

                    ForEach(0..<game.board.count, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<game.board[row].count, id: \.self) { col in
                                CellView(cell: game.board[row][col])
                            }
                        }
                    }
                    
                    Spacer()

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
        .onAppear() {
            game.backgroundAudioManager.playSounds(soundfile: "gameBackground", type: ".mp3", repeatNum: -1)
        }
        .onDisappear() {
            game.backgroundAudioManager.playSounds(soundfile: "homebackground", type: ".mp3", repeatNum: -1)
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    private static var gameSettings = GameSettings()
    static var previews: some View {
        let home = HomeView()
        let mode = ModeView(viewManipulation: home.$viewManipulation)
        
        GameView(isPlaying: mode.$isPlaying)
            .environmentObject(Game(settings: gameSettings))
    }
}