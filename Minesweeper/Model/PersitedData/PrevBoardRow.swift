//
//  PrevBoardRow.swift
//  Minesweeper
//
//  Created by Truong Nhat Anh on 12/08/2022.
//

import Foundation
import RealmSwift

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
