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

