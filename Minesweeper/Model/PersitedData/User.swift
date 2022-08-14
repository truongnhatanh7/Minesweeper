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

