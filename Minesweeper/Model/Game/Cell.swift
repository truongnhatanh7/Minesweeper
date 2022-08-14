/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Truong Nhat Anh
 ID: 3878231
 Created date: 10/08/2022
 Last modified: 11/08/2022
 Acknowledgement: COSC2659 Lecture slides, hackingwithswift.com, stackoverflow.com, minesweepergame.com
 */

import SwiftUI
import Foundation
import RealmSwift

class Cell: ObservableObject {
    var row: Int
    var col: Int
    
    @Published var status: Status
    @Published var isOpened: Bool
    @Published var isFlagged: Bool
    @Published var currentBombs: Int
    
    init (row: Int, column: Int) {
        self.row = row
        self.col = column
        self.status = .normal
        self.isOpened = false
        self.isFlagged = false
        self.currentBombs = 0
    }
    
    var image: Image {
        if !isOpened && isFlagged {
            return Image("flag")
        }
        
        switch status {
        case .bomb:
            if isOpened {
                return Image("bomb")
            }
            
            return Image("normal")
        case .normal:
            return Image("normal")
        case .opened:
            if !isOpened {
                return Image("normal")
            }
            
            if currentBombs == 0 {
                return Image("empty")
            }
            
            return Image("\(currentBombs)")
        }
        
    }
    
}

extension Cell {
    enum Status: Equatable {
        case normal
        case bomb
        case opened
    }
}

