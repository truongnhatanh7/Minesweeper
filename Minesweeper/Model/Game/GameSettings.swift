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

import Foundation
import SwiftUI
import AVKit

class GameSettings: ObservableObject {
    @Published var numRows = 10
    @Published var numCols = 10
    @Published var numBombs = 10
    @Published var isProcessing = false
    // minWidth, minHeight is created for mac catalyst to created default bounds for preserving layouts
    // maxWidth, maxHeight is based on iPad Pro 12inch size
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
    var maxWidth: CGFloat = 1024
    var maxHeight: CGFloat = 1366
    var squareModifer = 0.0
    var squareSize: CGFloat {
        #if targetEnvironment(macCatalyst)
        return 1024.0 / CGFloat(numCols)
        #else
            return UIScreen.main.bounds.width / CGFloat(numCols)
        #endif
    }
}
