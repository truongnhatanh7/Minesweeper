//
//  User.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 09/08/2022.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username = ""
    @Persisted var password = ""
    @Persisted var prevBoard = List<PrevBoardRow>() // 0 close+normal | 1 close+bomb | 2 flag+normal | 3 flag+bomb | 4 open+normal
    @Persisted var achievements = List<String>()
    @Persisted var useOldBoard = false
    @Persisted var highscore = 0
    @Persisted var moveHistory = List<Move>()
    @Persisted var canContinue = false
}

class Move: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var row: Int
    @Persisted var col: Int
}

class PrevBoardRow: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var boardRow = List<PersistedCell>()
}

class PersistedCell: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var row: Int
    @Persisted var col: Int
    @Persisted var status: PersistedStatus
    @Persisted var isOpened: Bool
    @Persisted var isFlagged: Bool

    enum PersistedStatus: Int, PersistableEnum {
        case normal
        case bomb
        case opened
    }
}
