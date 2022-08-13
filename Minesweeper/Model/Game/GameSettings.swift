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
    var minWidth: CGFloat {
        #if targetEnvironment(macCatalyst)
        return 1024.0
        #else
            return 0
        #endif
    }
    var minHeight: CGFloat {
        #if targetEnvironment(macCatalyst)
        return 1280.0
        #else
        return 0.0
        #endif
    }
    var squareModifer = 0.0
    var squareSize: CGFloat {
        #if targetEnvironment(macCatalyst)
        return 1024.0 / CGFloat(numCols)
        #else
            return UIScreen.main.bounds.width / CGFloat(numCols)
        #endif
    }
}
