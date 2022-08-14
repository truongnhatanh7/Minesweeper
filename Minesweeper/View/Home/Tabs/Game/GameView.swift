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

struct GameView: View {
    @EnvironmentObject var game: Game
    @Binding var isPlaying: Bool
    var body: some View {
        ZStack {
            if !game.settings.isProcessing {
                VStack(spacing: 0) {
                    HStack {
                        Button  {
                            isPlaying = false
                        } label: {
                            Text("CHANGE MODE")
                                .italic()
                                .fontWeight(.bold)
                        }
                        
                        Text("/")
                            .padding()
                        
                        Button  {
                            game.initializeBoard(numBombs: game.settings.numBombs)
                            game.score = 0
                            game.flagCount = 0
                            game.isWin = false
                            game.isLose = false
                        } label: {
                            Text("RESTART")
                                .italic()
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("\(game.settings.numBombs) BOMBS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    
                    HStack {
                        Text("SCORE: \(game.score)")
                            .italic()
                            .fontWeight(.bold)
                            .modifier(ButtonModifer())
                        Spacer()
                        Text("FLAG: \(game.flagCount)")
                            .italic()
                            .fontWeight(.bold)
                            .modifier(ButtonModifer())
                        
                    }
                    .padding(.horizontal, 48)
                    
                    Spacer()
                    
                    if game.isWin {
                        GameModalView(content: "YOU WIN")
                    } else if game.isLose {
                        GameModalView(content: "YOU LOSE")
                    } else {
                        ForEach(0..<game.board.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<game.board[row].count, id: \.self) { col in
                                    CellView(cell: game.board[row][col])
                                }
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
        .onAppear() {
            game.backgroundAudioManager.playSounds(soundfile: "gameBackground", type: ".mp3", repeatNum: -1)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { output in
            if !game.isLose {
                game.saveStateBeforeExit(currentUsername: game.currentUsername, board: game.board)
            }
            
        }
        .onDisappear() {
            game.backgroundAudioManager.playSounds(soundfile: "background", type: ".mp3", repeatNum: -1)
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
