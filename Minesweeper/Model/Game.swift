//
//  Game.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 07/08/2022.
//

import Foundation
import SwiftUI
import AVKit
import RealmSwift


class Game: ObservableObject {
    @Published var settings: GameSettings
    @Published var audioManager: AudioManager
    @Published var backgroundAudioManager: AudioManager
    @Published var board: [[Cell]]
    @Published var prevBoard: [[Cell]]
    @Published var score: Int
    @Published var flagCount: Int
    @Published var isWin: Bool
    @Published var isLose: Bool
    @Published var currentUsername: String
    @Published var localRealm: Realm?
    @Published var currentUserId: ObjectId
    @Published var canContinue: Bool

    
    // MARK: Init
    init (settings: GameSettings) {
        self.settings = settings
        self.board = [[Cell]]()
        self.prevBoard = [[Cell]]()
        self.score = 0
        self.flagCount = 0
        self.isWin = false
        self.isLose = false
        self.audioManager = AudioManager()
        self.backgroundAudioManager = AudioManager()
        self.currentUsername = ""
        self.currentUserId = ObjectId()
        self.canContinue = false
        openRealm()
//        backgroundAudioManager.playSounds(soundfile: "gameBackground", type: ".mp3", repeatNum: -1)
    }
    
    // MARK: Init prev board
    func initializePrevBoard() {
        settings.isProcessing = true
        var newBoard = [[Cell]]()
        self.score = 0
        self.settings.numBombs = 0
        
        for row in 0..<settings.numRows {
            var column = [Cell]()
            for col in 0..<settings.numCols {
                column.append(Cell(row: row, column: col))
            }
            newBoard.append(column)
        }
        
        
        if let user = localRealm!.object(ofType: User.self, forPrimaryKey: currentUserId) {
            let currentBoard = user.prevBoard
            for row in 0..<10 {
                let currentRow = currentBoard[row].boardRow
                for col in 0..<10 {
                    newBoard[row][col].isOpened = false
                    newBoard[row][col].isFlagged = currentRow[col].isFlagged
                    if newBoard[row][col].isFlagged { flagCount += 1 }
                    if currentRow[col].status == .bomb {
                        self.settings.numBombs += 1
                        newBoard[row][col].status = .bomb
                    } else {
                        newBoard[row][col].status = .normal
                    }
                }
            }
            self.board = newBoard
            revealPrevCells(user: user, newBoard: newBoard)
            setContinueState(value: false)
        }

        settings.isProcessing = false
    }
    
    // MARK: Reveal prev cells
    func revealPrevCells(user: User, newBoard: [[Cell]]) {
        do {
            try localRealm!.write {
                var cur = user.moveHistory.count - 1
                let moveHistory = Array(user.moveHistory)
                while cur >= 0 {
                    let currentMove = moveHistory[cur]
                    revealCell(cell: newBoard[currentMove.row][currentMove.col])
                    cur -= 1
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Init board
    func initializeBoard(numBombs: Int) {

        var newBoard = [[Cell]]()
        settings.isProcessing = true
        self.score = 0
        
        for row in 0..<settings.numRows {
            var column = [Cell]()
            for col in 0..<settings.numCols {
                column.append(Cell(row: row, column: col))
            }
            newBoard.append(column)
        }
        
        var currentBombs = 0
        while currentBombs < numBombs {
            let randRow = Int.random(in: 0..<settings.numRows)
            let randCol = Int.random(in: 0..<settings.numCols)
            
            if newBoard[randRow][randCol].status != .bomb {
                newBoard[randRow][randCol].status = .bomb
                currentBombs += 1;
            }
        }
        
        settings.isProcessing = false
        resetMoveHistory()
        self.board = newBoard
    }
    
    // MARK: Reset move history
    func resetMoveHistory() {
        do {
            try localRealm!.write({
                let user = localRealm!.object(ofType: User.self, forPrimaryKey: currentUserId)
                user?.moveHistory.removeAll()
            })
        } catch {
            print(error)
        }
    }
    
    // MARK: Click cell
    func click(cell: Cell) {
        if cell.status == .bomb {
            audioManager.playSounds(soundfile: "bomb", type: ".mp3", repeatNum: 0)
            cell.isOpened = true
            setContinueState(value: false)
            for row in 0..<board.count {
                for col in 0..<board[0].count {
                    board[row][col].isOpened = true
                }
            }
            
            isLose = true
            // TODO: Handle lose condition
            
        } else {
            audioManager.playSounds(soundfile: "touch", type: ".wav", repeatNum: 0)
            revealCell(cell: cell)
            addMove(cell: cell)
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
    
    // MARK: Get num count
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
    
    // MARK: Reveal cell
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
        
        cell.status = .opened
        cell.currentBombs = openedCount
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
    
    // MARK: Toggle flag
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
}

extension Game {
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Do something, usually updating the schema's variables here
                }
            })

            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func addUser(username: String, password: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let user = User()
                    user.username = username
                    user.password = password
                    user.canContinue = false
                    for row in 0..<10 {
                        user.prevBoard.append(PrevBoardRow())
                        for col in 0..<10 {
                            let cell = PersistedCell()
                            cell.row = row
                            cell.col = col
                            user.prevBoard[row].boardRow.append(cell)
                        }
                    }
                    localRealm.add(user)
                    print("Added new user to Realm!")
                }
                let users = getUsers()
                for user in users {
                    if user.username == username {
                        currentUserId = user._id
                    }
                }
            } catch {
                print("Error adding user to Realm", error)
            }
        }
    }
    
    func getUsers() -> [User] {
        var users = [User]()
        if let localRealm = localRealm {
            let allUsers = localRealm.objects(User.self)
            allUsers.forEach { user in
                users.append(user)
            }
        }
        return users
    }
    
    func saveStateBeforeExit(currentUsername: String, board: [[Cell]]) {
        let user = localRealm!.object(ofType: User.self, forPrimaryKey: currentUserId)
        if let user = user {
            do {
                try localRealm!.write {
                    let currentBoard = user.prevBoard
                    for row in 0..<board.count {
                        let currentRow = currentBoard[row].boardRow
                        for col in 0..<board[0].count {
                            currentRow[col].col = col
                            currentRow[col].row = row
                            currentRow[col].isOpened = board[row][col].isOpened
                            currentRow[col].isFlagged = board[row][col].isFlagged
                            currentRow[col].status = board[row][col].status == .bomb ? .bomb : .normal
                        }
                    }
                    
                }
            }
            catch {
                print("Error write file ", error)
            }
            
            setContinueState(value: true)
        }

    }
    
    func setContinueState(value: Bool) {
        do {
            try localRealm!.write {
                let user = localRealm!.object(ofType: User.self, forPrimaryKey: currentUserId)
                self.canContinue = value
                user?.canContinue = value
            }
        } catch {
            print(error)
        }
    }
    
    func addMove(cell: Cell) {
        do {
            try localRealm!.write {
                let users = localRealm!.objects(User.self)
                for user in users {
                    if user.username == currentUsername {
                        let move = Move()
                        move.row = cell.row
                        move.col = cell.col
                        user.moveHistory.append(move)
                        user.highscore = self.score
                    }
                }
            }
        } catch {
            print("error:", error)
        }
    }
    
}

