//
//  RealmManager.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 09/08/2022.
//

import Foundation
import SwiftUI
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    
    @Published var users: [User] = []
    @EnvironmentObject var game: Game
    
    init() {
        openRealm()
        self.users = getUsers()
    }
    
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
                    for row in 0..<10 {
                        user.prevBoard.append(PrevBoardRow())
                        for _ in 0..<10 {
                            user.prevBoard[row].boardRow.append(PersistedCell())
                        }
                    }
                    localRealm.add(user)
                    print("Added new user to Realm!")
                }
            } catch {
                print("Error adding user to Realm", error)
            }
        }
    }
    
    func getUsers() -> [User] {
        if let localRealm = localRealm {
            let allUsers = localRealm.objects(User.self)
            allUsers.forEach { user in
                users.append(user)
            }
        }
        return self.users
    }
    
    func saveStateBeforeExit(currentUsername: String, board: [[Cell]]) {
        let users = getUsers()
        for user in users {
            if user.username == currentUsername {
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
                                currentRow[col].status = board[row][col].status == .normal ? .normal : board[row][col].status == .bomb ? .bomb : .opened
                            }
                        }
                        
                    }
                }
                catch {
                    print("Error write file ", error)
                }
            }
        }
    }
    
}
