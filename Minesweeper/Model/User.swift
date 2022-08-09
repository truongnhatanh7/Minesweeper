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
    @Persisted var prevBoard = List<PrevBoardRow>() // 0 close | 1 open | 2 flag
    @Persisted var achievements = List<String>()
    
}

class PrevBoardRow: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var boardRow = List<Int>()
}
