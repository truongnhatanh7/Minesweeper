/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: dd/mm/yyyy 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

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
