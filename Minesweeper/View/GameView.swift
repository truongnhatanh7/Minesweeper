//
//  GameView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Total bombs: \(game.settings.numBombs)")
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
        
    }
}

struct GameView_Previews: PreviewProvider {
    private static var gameSettings = GameSettings()
    static var previews: some View {
        GameView()
            .environmentObject(Game(settings: gameSettings))
    }
}
