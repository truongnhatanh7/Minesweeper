//
//  CellView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var game: Game
    @State private var fadeOut = false
    let cell: Cell
    
    var body: some View {
        cell.image
            .resizable()
            .scaledToFill()
            .frame(width: game.settings.squareSize, height: game.settings.squareSize, alignment: .center)
            .opacity(fadeOut ? 0 : 1)
            .animation(.easeInOut(duration: 0.2), value: fadeOut)
            .onTapGesture {
                self.fadeOut.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        game.click(cell: cell)
                        self.fadeOut.toggle()
                    }
                }
                
            }
            .onLongPressGesture {
                self.fadeOut.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        game.toggleFlag(cell: cell)
                        self.fadeOut.toggle()
                    }
                }
            }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: Cell(row: 0, column: 0)).environmentObject(Game(settings: GameSettings()))
    }
}
