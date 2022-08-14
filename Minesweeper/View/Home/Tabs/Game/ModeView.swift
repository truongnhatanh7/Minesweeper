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

struct ModeView: View {
    @EnvironmentObject var game: Game
    @State var currentMode: Int = 10
    
    @Binding var viewManipulation: Int
    @State var isPlaying: Bool = false
    var body: some View {
        if isPlaying {
            GameView(isPlaying: $isPlaying)
        } else {
            VStack(alignment: .center) {
                Spacer()
                Text("Hi \(game.currentUsername)".uppercased())
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                VStack(spacing: 14) {
                    Spacer()
                    Button {
                        isPlaying = true
                        game.settings.numBombs = 10
                        game.initializeBoard(numBombs: 10)
                    } label: {
                        Text("10 bombs")
                    }
                    .modifier(ButtonModifer())
                    
                    
                    Button {
                        isPlaying = true
                        game.settings.numBombs = 15
                        game.initializeBoard(numBombs: 15)
                    } label: {
                        Text("15 bombs")
                    }
                    .modifier(ButtonModifer())
                    
                    Button {
                        isPlaying = true
                        game.settings.numBombs = 20
                        game.initializeBoard(numBombs: 20)
                    } label: {
                        Text("20 bombs")
                    }
                    .modifier(ButtonModifer())
                    
                    if game.canContinue {
                        Button {
                            game.initializePrevBoard()
                            isPlaying = true
                        } label: {
                            Text("Continue")
                        }
                        .modifier(ButtonModifer())
                    }
                    Spacer()
                    Button {
                        viewManipulation = 0
                    } label: {
                        Text("Log out")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: 1024,
                minHeight: 0,
                maxHeight: 1366,
                alignment: .center
            )
            .transition(.opacity)
            .onAppear() {
                let isPlaying = game.backgroundAudioManager.audioPlayer?.isPlaying ?? false
                let fileName = game.backgroundAudioManager.audioPlayer?.url?.relativePath
                if let fileNameCheck = fileName?.contains("background") {
                    if isPlaying && !fileNameCheck {
                        game.backgroundAudioManager.playSounds(soundfile: "background", type: ".mp3", repeatNum: -1)
                    }
                } else {
                    game.backgroundAudioManager.playSounds(soundfile: "background", type: ".mp3", repeatNum: -1)
                }
            }
        }
    }
}

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
        ModeView(viewManipulation: HomeView().$viewManipulation)
            .environmentObject(Game(settings: GameSettings()))
    }
}
