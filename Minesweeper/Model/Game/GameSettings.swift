//
//  GameSettings.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import Foundation
import SwiftUI
import AVKit

class GameSettings: ObservableObject {
    @Published var numRows = 10
    @Published var numCols = 10
    @Published var numBombs = 10
    @Published var isProcessing = false
    
    var squareSize: CGFloat {
        // Screen width / cols = square size
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width / CGFloat(numCols)
        }
        return 768 / CGFloat(numCols)
    }
}
