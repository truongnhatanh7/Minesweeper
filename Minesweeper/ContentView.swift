//
//  ContentView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(
                  minWidth: 0,
                  maxWidth: 1024,
                  minHeight: 0,
                  maxHeight: 1366,
                  alignment: .center
                )
            .background(Color("background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
