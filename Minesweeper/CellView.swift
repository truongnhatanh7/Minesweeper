//
//  CellView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var game: Game
    let cell: Cell
    
    var body: some View {
        cell.image
            .resizable()
            .scaledToFill()
            .frame(width: game.settings.squareSize, height: game.settings.squareSize, alignment: .center)
            .onTapGesture {
                game.click(cell: cell)
            }
            .onLongPressGesture {
                game.toggleFlag(cell: cell)
            }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: Cell(row: 0, column: 0)).environmentObject(Game(settings: GameSettings()))
    }
}
