//
//  GameSettings.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    @Published var numRows = 10
    @Published var numCols = 10
    @Published var numBombs = 10
    
    var squareSize: CGFloat {
        // Screen width / cols = square size
        UIScreen.main.bounds.width / CGFloat(numCols)
    }
}
