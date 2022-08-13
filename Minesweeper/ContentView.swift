//
//  ContentView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: Game
    var body: some View {
        GeometryReader { bound in
            HomeView()
                .frame(
                    minWidth: game.settings.minWidth,
                      maxWidth: 1024,
                    minHeight: game.settings.minHeight,
                      maxHeight: 1366,
                      alignment: .center
                    )
                .background(Color("background"))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
