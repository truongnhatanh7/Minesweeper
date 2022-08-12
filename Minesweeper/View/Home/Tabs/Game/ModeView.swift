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
            GameView(isPlaying: $isPlaying)
        } else {
            VStack(alignment: .center) {
                Spacer()
                Text("Hi \(game.currentUsername)")
                    .font(.title)
                    .fontWeight(.bold)
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
                    .modifier(ButtonModifier())
                    
                    
                    Button {
                        isPlaying = true
                        game.settings.numBombs = 15
                        game.initializeBoard(numBombs: 15)
                    } label: {
                        Text("15 bombs")
                    }
                    .modifier(ButtonModifier())
                    
                    Button {
                        isPlaying = true
                        game.settings.numBombs = 20
                        game.initializeBoard(numBombs: 20)
                    } label: {
                        Text("20 bombs")
                    }
                    .modifier(ButtonModifier())
                    .padding(.bottom, 48)
                    
                    if game.canContinue {
                        Button {
                            isPlaying = true
                            game.initializePrevBoard()
                        } label: {
                            Text("Continue")
                        }
                        .modifier(ButtonModifier())
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
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .center
                )
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
            .environmentObject(Game(settings: GameSettings()))
    }
}
