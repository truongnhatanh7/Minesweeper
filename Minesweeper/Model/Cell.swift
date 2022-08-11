//
//  Cell.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//
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
    
    init (row: Int, column: Int) {
        self.row = row
        self.col = column
        self.status = .normal
        self.isOpened = false
        self.isFlagged = false
        self.currentBombs = 0
    }
    
    
}

extension Cell {
    enum Status: Equatable {
        case normal
        case bomb
        case opened 
    }
}
