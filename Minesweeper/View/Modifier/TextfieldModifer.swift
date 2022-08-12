//
//  TextfieldModifer.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

import SwiftUI

struct TextfieldModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color("text"), lineWidth: 1)
            )
    }
}

//struct TextfieldModifer_Previews: PreviewProvider {
//    static var previews: some View {
//        @Binding var text
//        TextField("Username", text: $text)
//    }
//}
