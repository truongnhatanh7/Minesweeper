//
//  Game.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import Foundation
import SwiftUI
import AudioToolbox

class Game: ObservableObject {
    @Published var settings: GameSettings
    @Published var audioManager: AudioManager
    @Published var backgroundAudioManager: AudioManager
    @Published var board: [[Cell]]
    @Published var score: Int
    @Published var flagCount: Int
    @Published var isWin: Bool
    @Published var isLose: Bool
    
    
    init (settings: GameSettings) {
        self.settings = settings
        self.board = Self.initializeBoard(settings: settings)
        self.score = 0
        self.flagCount = 0
        self.isWin = false
        self.isLose = false
        self.audioManager = AudioManager()
        self.backgroundAudioManager = AudioManager()
//        backgroundAudioManager.playSounds(soundfile: "gameBackground", type: ".mp3", repeatNum: -1)
    }
    
    static func initializeBoard(settings: GameSettings) -> [[Cell]] {
        var newBoard = [[Cell]]()
        
        for row in 0..<settings.numRows {
            var column = [Cell]()
            for col in 0..<settings.numCols {
                column.append(Cell(row: row, column: col))
            }
            newBoard.append(column)
        }
        
        var currentBombs = 0
        while currentBombs < settings.numBombs {
            let randRow = Int.random(in: 0..<settings.numRows)
            let randCol = Int.random(in: 0..<settings.numCols)
            
            if newBoard[randRow][randCol].status != .bomb {
                newBoard[randRow][randCol].status = .bomb
                currentBombs += 1;
            }
        }
//        self.board = newBoard
        
        return newBoard
    }
    
    func click(cell: Cell) {
        if cell.status == .bomb {
            audioManager.playSounds(soundfile: "bomb", type: ".mp3", repeatNum: 0)
            cell.isOpened = true
//            isLose = true
            for row in 0..<board.count {
                for col in 0..<board[0].count {
                    board[row][col].isOpened = true
                }
            }
            // TODO: Handle lose condition
            
        } else {
            audioManager.playSounds(soundfile: "touch", type: ".wav", repeatNum: 0)
            revealCell(cell: cell)
        }
        
        self.objectWillChange.send()
    }
    
    func checkGameCondition() -> Bool {
        var validCellCount = 0
        if flagCount == settings.numBombs {
            for row in 0..<board.count {
                for col in 0..<board[0].count {
                    if board[row][col].status == .bomb && board[row][col].isFlagged {
                        validCellCount += 1
                    }
                }
            }
            if validCellCount == settings.numBombs {
                return true
            }
        }
        return false
    }
    
    private func getOpenedCount(cell: Cell) -> Int {
        let row = cell.row
        let col = cell.col
        
        let minRow = max(row - 1, 0)
        let minCol = max(col - 1, 0)
        let maxRow = min(row + 1, board.count - 1)
        let maxCol = min(col + 1, board[0].count - 1)
        
        var bombsCount = 0
        for row in minRow...maxRow {
            for col in minCol...maxCol {
                if (board[row][col].status == .bomb) {
                    bombsCount += 1
                }
            }
        }
        return bombsCount
    }
    
    private func revealCell(cell: Cell) {
        // DFS to explore new cells
        guard !cell.isOpened else {
            return
        }
        
        guard !cell.isFlagged else {
            return
        }
        
        guard cell.status != .bomb else {
            return
        }
        
        let openedCount = getOpenedCount(cell: cell)
        
        cell.status = .opened(openedCount)
        cell.isOpened = true
        score += 1
        
        // If empty -> keep exploring surroundings cells
        if openedCount == 0 {
            revealCell(cell: board[max(0, cell.row - 1)][cell.col]) // go up
            revealCell(cell: board[min(board.count - 1, cell.row + 1)][cell.col]) // go down
            revealCell(cell: board[cell.row][max(0, cell.col - 1)]) // go left
            revealCell(cell: board[cell.row][min(board[0].count - 1, cell.col + 1)]) // go right
        }
    }
    
    func toggleFlag(cell: Cell) {
        guard !cell.isOpened else {
            return
        }
        audioManager.playSounds(soundfile: "flag", type: ".mp3", repeatNum: 0)
        if cell.isFlagged {
            flagCount -= 1
            cell.isFlagged = false
        } else if flagCount < settings.numBombs {
            flagCount += 1
            cell.isFlagged = true
        }
        self.objectWillChange.send()
    }
    
    func playAgain() {
//        self.initializeBoard(settings: settings)
        self.board = Game.initializeBoard(settings: self.settings)
        self.score = 0
        self.flagCount = 0
        self.isWin = false
        self.isLose = false
    }
}
