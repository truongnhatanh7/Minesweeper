//
//  ButtonModifier.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 11/08/2022.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding(.horizontal, 28)
            .padding(.vertical, 12)
            .background {
                Capsule().foregroundColor(Color("neonGreen"))
            }
    }
}

struct ButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test").modifier(ButtonModifier())
    }
}
