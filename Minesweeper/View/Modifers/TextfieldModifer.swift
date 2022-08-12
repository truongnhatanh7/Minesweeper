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
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("text"), lineWidth: 1.2)
            )
    }
}
