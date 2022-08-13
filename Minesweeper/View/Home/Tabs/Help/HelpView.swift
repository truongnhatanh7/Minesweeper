//
//  HelpView.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 11/08/2022.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            Text("HELP")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
                .padding()
            Spacer()
            WebView(url: URL(string: "https://minesweepergame.com/strategy/how-to-play-minesweeper.php#:~:text=Minesweeper%20is%20a%20game%20where,mine%20you%20lose%20the%20game!")!)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
            Spacer()
        }
        .frame(
              minWidth: 0,
              maxWidth: 1024,
              minHeight: 0,
              maxHeight: 1366,
              alignment: .center
            )
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
