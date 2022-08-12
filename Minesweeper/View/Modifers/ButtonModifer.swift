//
//  ButtonModifer.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

import SwiftUI

struct ButtonModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 32)
            .padding(.vertical, 10)
            .background(Color("neonGreen"))
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}
