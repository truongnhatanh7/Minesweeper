/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

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
            .clipShape(
                RoundedRectangle(cornerRadius: 4)
            )
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
