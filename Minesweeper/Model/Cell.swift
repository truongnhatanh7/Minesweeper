//
//  Cell.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//
import SwiftUI
import Foundation

class Cell: ObservableObject {
    var row: Int
    var col: Int
    
    @Published var status: Status
    @Published var isOpened: Bool
    @Published var isFlagged: Bool
    
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
        case .opened(let currentBombs):
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
    }
    
    
}

extension Cell {
    enum Status: Equatable {
        case normal
        case bomb
        case opened(Int) // 1 -> num of surrounding bombs, 0 -> none
    }
}
